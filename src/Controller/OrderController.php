<?php

namespace App\Controller;

use App\Entity\Order;
use App\Entity\OrderItem;
use App\Entity\Product;
use App\Entity\User;
use App\Form\OrderType;
use App\Form\UserType;
use App\Repository\OrderRepository;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;

class OrderController extends AbstractController
{
    #[Route('/order', name: 'app_order')]
    public function index(EntityManagerInterface $em, OrderRepository$orderRepository, SessionInterface $session, Request $request, ProductRepository $productRepo): Response
    {

           $cart = $session->get('cart', []);

           $order = new Order();

           $user = new User();
           $form = $this->createForm(UserType::class, $user);
           $form->handleRequest($request);

           if($form->isSubmitted() && $form->isValid()) {

               $total = 0;

               foreach($cart as $id=>$quantity){
                   $orderItem = new OrderItem();
                   $product = $productRepo->find($id);
                   $orderItem->setProduct($product);
                   $orderItem->setPrice($product->getPrice()*$quantity);
                   $orderItem->setQuantity($quantity);
                   $orderItem->setOrderAssociation($order);
                   $total+= $orderItem->getPrice();
                   $em->persist($orderItem);
               }

               $order->setDeliveryAdress('');
               $order->setTotalAmount($total);
               $order->setStatus('En Attente de Paiement');
               $order->setUser($user);
               $em->persist($user);
               $em->persist($order);
               $em->flush();
               $orderId = $order->getId();
               $session->set('orderId', $orderId);

               $tokenProvider = $this->container->get('security.csrf.token_manager');
               $token = $tokenProvider->getToken('stripe_token')->getValue();


               \Stripe\Stripe::setApiKey('sk_test_51MEt4cE9Rf4SSnE3hA9uNZPxKtaaSsUMg36v7cHqqP5zzpn58QWMwRzimkNIDo34RiNr4CWuDAJkflHms8tvmReX00eJmyGZci');
               $cart = $session->get('cart', []);

               $items = [];
               foreach($cart as $id=>$quantity){
                   $product = $productRepo->find($id);

                   $items[] = [  'price_data' => [
                       'currency' => 'eur',
                       'product_data' => [
                           'name' => $product
                       ],
                       'unit_amount' => $product->getPrice()
                   ],
                       'quantity' => $quantity,
                   ];
               }

                   $session = \Stripe\Checkout\Session::create([
                       'line_items' => $items,
                       'mode' => 'payment',
                       'success_url' => 'http://127.0.0.1:8000/success/'.$token,
                       'cancel_url' => 'http://127.0.0.1:8000/checkout_error'

                   ]);

               return $this->redirect($session->url, 303);
           }

        return $this->render('order/index.html.twig', [
            'renderForm' => $form
        ]);
    }


    #[Route('/success/{token}', name: 'app_success')]
    public function successCheckout($token, SessionInterface $session, EntityManagerInterface $em, OrderRepository $orderRepository): Response
    {

        $order = $orderRepository->find($session->get('orderId'));

        if ($this->isCsrfTokenValid('stripe_token', $token)) {
            $order->setStatus("Validé");
            $em->flush();
            return new Response("ok");
        } else {
            echo "error";
            exit();
        }

        return $this->render('success/index.html.twig', [

        ]);

    }


}
