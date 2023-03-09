<?php

namespace App\Controller;

use App\Entity\Product;
use App\Form\Product1Type;
use App\Repository\ProductRepository;
use DateTimeImmutable;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

#[Route('/product')]
class ProductController extends AbstractController
{
    #[Route('/', name: 'app_product_index', methods: ['GET'])]
    public function index(ProductRepository $productRepository): Response
    {

        return $this->render('product/index.html.twig', [
            'products' => $productRepository->findAll(),
        ]);
    }

    #[Route('/search', name: 'search')]
    public function searchProduct(Request $request, ProductRepository $productRepository){
        $q = $request->query->get('q');
        $products = $productRepository->search($q);

        return $this->render('home/resultSearch.html.twig', [
            'products' => $products,
        ]);

    }

    #[Security("is_granted('ROLE_ADMIN') or user === post.getUser()")]
    #[Route('/new', name: 'app_product_new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $em, ProductRepository $productRepository, SluggerInterface $slugger): Response
    {
        $product = new Product();
        $form = $this->createForm(Product1Type::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $imageFile = $form->get('image')->getData();


            if ($imageFile) {
                $originalFilename = pathinfo($imageFile->getClientOriginalName(), PATHINFO_FILENAME);

                $safeFilename = $slugger->slug($originalFilename);
                $newFilename = $safeFilename . '-' . uniqid() . '.' . $imageFile->guessExtension();


                try {
                    $imageFile->move(
                        $this->getParameter('uploads'),
                        $newFilename
                    );
                } catch (FileException $e) {

                }

                $product->setImage($newFilename);

            }
            $product->setCreatedAt(new DateTimeImmutable());
            $product->setUpdatedAt(new DateTimeImmutable());
            $product->setSlug($slugger->slug($product->getName().uniqid()));
            $productRepository->save($product, true);

            $em->persist($product);
            $em->flush();

            return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('product/new.html.twig', [
            'product' => $product,
            'form' => $form,
        ]);
    }

//    #[Route('/{id}', name: 'app_product_show', methods: ['GET'])]
//    public function show(Product $product): Response
//    {
//        return $this->render('product/show.html.twig', [
//            'product' => $product,
//        ]);
//    }

    #[Route('/{slug}', name: 'app_product_show', methods: ['GET'])]
    public function show(Product $product): Response
    {
        return $this->render('product/pageProduct.html.twig', [
            'product' => $product,
        ]);
    }

    #[Security("is_granted('ROLE_ADMIN') or user === post.getUser()")]
    #[Route('/{id}/edit', name: 'app_product_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, EntityManagerInterface $em, Product $product, ProductRepository $productRepository, SluggerInterface $slugger): Response
    {

        $form = $this->createForm(Product1Type::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $imageFile = $form->get('image')->getData();


            if ($imageFile) {
                $originalFilename = pathinfo($imageFile->getClientOriginalName(), PATHINFO_FILENAME);

                $safeFilename = $slugger->slug($originalFilename);
                $newFilename = $safeFilename . '-' . uniqid() . '.' . $imageFile->guessExtension();


                try {
                    $imageFile->move(
                        $this->getParameter('uploads'),
                        $newFilename
                    );
                } catch (FileException $e) {

                }
                $product->setCreatedAt(new DateTimeImmutable());
                $product->setUpdatedAt(new DateTimeImmutable());
                $product->setSlug($slugger->slug($product->getName().uniqid()));
                $product->setImage($newFilename);
                $productRepository->save($product, true);
                $em->persist($product);
                $em->flush();

            }

            return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('product/edit.html.twig', [
            'product' => $product,
            'form' => $form,
        ]);
    }

    #[Security("is_granted('ROLE_ADMIN') or user === post.getUser()")]
    #[Route('/{slug}', name: 'app_product_delete', methods: ['POST'])]
    public function delete(Request $request, Product $product, ProductRepository $productRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$product->getSlug(), $request->request->get('_token'))) {
            $productRepository->remove($product, true);
        }

        return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
    }
}
