<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20230208142344 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE product_console (product_id INT NOT NULL, console_id INT NOT NULL, INDEX IDX_E7DAD4064584665A (product_id), INDEX IDX_E7DAD40672F9DD9F (console_id), PRIMARY KEY(product_id, console_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE product_console ADD CONSTRAINT FK_E7DAD4064584665A FOREIGN KEY (product_id) REFERENCES product (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE product_console ADD CONSTRAINT FK_E7DAD40672F9DD9F FOREIGN KEY (console_id) REFERENCES console (id) ON DELETE CASCADE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE product_console DROP FOREIGN KEY FK_E7DAD4064584665A');
        $this->addSql('ALTER TABLE product_console DROP FOREIGN KEY FK_E7DAD40672F9DD9F');
        $this->addSql('DROP TABLE product_console');
    }
}
