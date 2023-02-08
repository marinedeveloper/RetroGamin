<?php

namespace App\Service;

use App\Entity\Product;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class Cart
{
    private $session;
    private $params;

    public function __construct(ParameterBagInterface $params, RequestStack $requestStack){
            $this->session = $requestStack->getSession();
            $this->params = $params;
    }

    public function add( Product $product, int $quantity){

        $session = $this->session;
        $cart = $session->get('cart', []);
        $cart[$product->getId()] = (int)$quantity;
//        $tva = $this->params->get("codeTva")[$product->getCodeTva()]/100+1;
        $session->set('cart', $cart);

    }


}