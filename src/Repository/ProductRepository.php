<?php

namespace App\Repository;

use App\Entity\Product;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Product>
 *
 * @method Product|null find($id, $lockMode = null, $lockVersion = null)
 * @method Product|null findOneBy(array $criteria, array $orderBy = null)
 * @method Product[]    findAll()
 * @method Product[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProductRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Product::class);
    }

    public function save(Product $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Product $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function searchTitle($search)
    {
        return $this->createQueryBuilder('p')
            ->select('p.name')
            ->where('p.name LIKE :search')
            ->setParameter('search', '%'.$search.'%')
            ->setMaxResults(10)
            ->getQuery()
            ->getSingleColumnResult()
            ;

    }

    public function search($search)
    {
        $qb = $this->createQueryBuilder('p')
            ->where('p.name LIKE :search')
            ->setParameter('search', '%'.$search.'%')
        ;
        return $qb->getQuery()->getResult();
    }



    /**
     * @return Product[] Returns an array of Product objects
     */
    public function filterByOrder($min, $max, $filter = null): array
    {

        $qb =  $this->createQueryBuilder('p')
            ->where('p.price between :min and :max')
            ->setParameter('min', $min)
            ->setParameter('max', $max);

        if($filter !== null){
            if($filter == 'price_desc') {
                $qb->orderBy('p.price', 'DESC');
            } elseif($filter == 'price_asc'){
                $qb->orderBy('p.price', 'ASC');
            } elseif($filter == 'name_desc') {
                $qb->orderBy('p.name', 'DESC');
            }elseif($filter == 'name_asc') {
                $qb->orderBy('p.name', 'ASC');
//            switch($option) ["price"=> "ASC"], ["price"=> "DESC"]  ["price"=> "ASC"],
//                : ["price"=> "ASC"]
//                 break;
//                case ["name"=> "DESC"] :
//            ["name"=> "ASC"]
            }
        } else {
            $qb->orderBy('p.id', 'ASC');
        }
            return $qb
                ->getQuery()
                ->getResult();
    }

//    public function findOneBySomeField($value): ?Product
//    {
//        return $this->createQueryBuilder('p')
//            ->andWhere('p.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
