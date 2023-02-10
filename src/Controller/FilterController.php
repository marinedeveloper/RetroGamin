<?php

namespace App\Controller;

use App\Entity\Product;
use App\Repository\ProductRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use function PHPUnit\Framework\isEmpty;

class FilterController extends AbstractController
{
    #[Route('/filter', name: 'app_filter')]
    public function index( Request $request, ProductRepository $productRepository): Response
    {
        $filter = $request->get("filterlist");

        $minPrice = $request->get('minPrice')*100;
        $maxPrice  = $request->get('maxPrice')*100;


        $products = $productRepository->filterByOrder($minPrice, $maxPrice, $filter);

        if($minPrice == '' && $maxPrice == ''){
            $maxRange = $productRepository->findOneBy([], ['price'=>'DESC'])->getPrice();
            $minRange = $productRepository->findOneBy([], ['price'=>'ASC'])->getPrice();
        } else {
            $minRange = $minPrice;
            $maxRange = $maxPrice;
        }

        return $this->render('home/index.html.twig', [
            'products'=> $products,
            'filter' => $filter,
            'maxRange'=> $maxRange,
            'minRange'=> $minRange
        ]);
    }
}
