<?php

namespace App\Controller;

use App\Entity\Product;
use App\Service\Cart;
use App\Repository\ProductRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;

class CartController extends AbstractController
{
    #[Route('/cart', name: 'app_cart')]
    public function index(  SessionInterface $session, ProductRepository $productRepository): Response
    {

        $cart = $session->get("cart", []);



        return $this->render('cart/index.html.twig', [
            'cart' => $cart,
            'products' => $productRepository->findById(array_keys($cart)),
        ]);


    }

    #[Route('/cart/{id}/add', name: 'add_cart')]
    public function addToCart(Cart $cart, Request $request, Product $product): Response
    {

        $quantity = $request->get("quantity");
        $cart->add($product, $quantity);
        $previousUrl = $request->headers->get("referer");
        return $this->redirect($previousUrl);
    }

}
