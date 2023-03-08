<?php

namespace App\Controller;

use App\Form\SearchType;
use App\Repository\PostRepository;
use App\Repository\ProductRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(ProductRepository $productRepository): Response
    {
        $products = $productRepository->findAll();
        $maxRange = $productRepository->findOneBy([], ['price' => 'DESC'])->getPrice();
        $minRange = $productRepository->findOneBy([], ['price' => 'ASC'])->getPrice();

        $form = $this->createForm(SearchType::class);

        return $this->render('home/index.html.twig', [
            'products' => $products,
            'maxRange' => $maxRange,
            'minRange' => $minRange,
            'form' => $form

        ]);
    }

    #[Route('/api/{offset}', name: 'api')]
    public function api( int $offset,  ProductRepository $productRepository): Response
    {

        $posts = $productRepository->findBy([], ["createdAt" => "DESC"], 5, $offset);


        return $this->render('home/api.html.twig', [
            'posts' => $posts,
        ]);

    }


    #[Route('/api/search/{search}', name: 'api_search')]
    public function autoComplete( string $search, ProductRepository $productRepository ): Response
    {

        return $this->json($productRepository->searchTitle($search));
        

    }
}
