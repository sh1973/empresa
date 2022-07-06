<?php
declare(strict_types=1);

/**
 * This file is part of the Phalcon Developer Tools.
 *
 * (c) Phalcon Team <team@phalcon.io>
 *
 * For the full copyright and license information, please view
 * the LICENSE file that was distributed with this source code.
 */

namespace Phalcon\DevTools\Generator;

use Phalcon\DevTools\Options\OptionsAware as ModelOption;
use Phalcon\DevTools\Utils;

class Snippet
{
    public function getSetter($originalFieldName, $fieldName, $type, $setterName)
    {
        $templateSetter = <<<EOD
    /**
     * Method to set the value of field %s
     *
     * @param %s \$%s
     * @return \$this
     */
    public function set%s(\$%s)
    {
        \$this->%s = \$%s;

        return \$this;
    }
EOD;
        return PHP_EOL.sprintf($templateSetter, $originalFieldName, $type, $fieldName, $setterName, $fieldName, $fieldName, $fieldName).PHP_EOL;
    }

    public function getValidateInclusion($fieldName, $varItems)
    {
        $templateValidateInclusion = <<<EOD
        \$this->validate(
            new InclusionIn(
                [
                    'field'    => '%s',
                    'domain'   => [%s],
                    'required' => true,
                ]
            )
        );
EOD;
        return PHP_EOL.sprintf($templateValidateInclusion, $fieldName, $varItems).PHP_EOL;
    }

    public function getValidationsMethod(array $pieces)
    {
        $templateValidations = <<<EOD
    /**
     * Validations and business logic
     *
     * @return boolean
     */
    public function validation()
    {
        \$validator = new Validation();

%s
    }
EOD;
        return PHP_EOL.sprintf($templateValidations, join('', $pieces)).PHP_EOL;
    }

    /**
     * @param string $namespace
     * @param string $useDefinition
     * @param string $classDoc
     * @param string $abstract
     * @param ModelOption $modelOptions
     * @param string $extends
     * @param string $content
     * @param string $license
     * @return string
     */
    public function getClass(
        string $namespace,
        string $useDefinition,
        string $classDoc = '',
        string $abstract = '',
        ModelOption $modelOptions,
        string $extends = '',
        string $content,
        string $license = ''
    ): string {
        $templateCode = <<<EOD
<?php

%s%s%s%s%sclass %s extends %s
{
%s
}
EOD;
        return sprintf(
            $templateCode,
            $license,
            $namespace,
            $useDefinition,
            $classDoc,
            $abstract,
            $modelOptions->getOption('className'),
            $extends,
            $content)
        .PHP_EOL;
    }

    public function getClassDoc($className, $namespace = '')
    {
        if (!empty($namespace)) {
            $namespace = str_replace('namespace ', '', $namespace);
            $namespace = str_replace(';', '', $namespace);
            $namespace = str_replace(["\r", "\n"], '', $namespace);

            $namespace = PHP_EOL . ' * @package ' . $namespace;
        }

        $classDoc = <<<EOD
/**
 * %s
 * %s
 * @autogenerated by Phalcon Developer Tools
 * @date %s
 */
EOD;
        return sprintf($classDoc, $className, $namespace, date('Y-m-d, H:i:s')).PHP_EOL;
    }

    public function getValidateEmail($fieldName)
    {
        $templateValidateEmail = <<<EOD
        \$validator->add(
            '%s',
            new EmailValidator(
                [
                    'model'   => \$this,
                    'message' => 'Please enter a correct email address',
                ]
            )
        );
EOD;
        return sprintf($templateValidateEmail, $fieldName).PHP_EOL.PHP_EOL;
    }

    public function getValidationEnd()
    {
        return <<<EOD
        return \$this->validate(\$validator);
EOD;
    }

    public function getAttributes($type, $visibility, \Phalcon\Db\ColumnInterface $field, $annotate = false, $customFieldName = null)
    {
        $fieldName = $customFieldName ?: $field->getName();

        if ($annotate) {
            $templateAttributes = <<<EOD
    /**
     *
     * @var %s%s%s
     * @Column(column="%s", type="%s"%s, nullable=%s)
     */
    %s \$%s;
EOD;

            return PHP_EOL.sprintf($templateAttributes,
                $type,
                $field->isPrimary() ? PHP_EOL.'     * @Primary' : '',
                $field->isAutoIncrement() ? PHP_EOL.'     * @Identity' : '',
                $field->getName(),
                $type,
                $field->getSize() ? ', length=' . $field->getSize() : '',
                $field->isNotNull() ? 'false' : 'true', $visibility, $fieldName).PHP_EOL;
        } else {
            $templateAttributes = <<<EOD
    /**
     *
     * @var %s
     */
    %s \$%s;
EOD;

            return PHP_EOL.sprintf($templateAttributes, $type, $visibility, $fieldName).PHP_EOL;
        }
    }

    public function getGetterMap($fieldName, $type, $setterName, $typeMap)
    {
        $templateGetterMap = <<<EOD
    /**
     * Returns the value of field %s
     *
     * @return %s
     */
    public function get%s()
    {
        if (\$this->%s) {
            return new %s(\$this->%s);
        } else {
           return null;
        }
    }
EOD;
        return PHP_EOL.sprintf($templateGetterMap, $fieldName, $type, $setterName, $fieldName, $typeMap, $fieldName).PHP_EOL;
    }

    public function getGetter($fieldName, $type, $getterName)
    {
        $templateGetter = <<<EOD
    /**
     * Returns the value of field %s
     *
     * @return %s
     */
    public function get%s()
    {
        return \$this->%s;
    }
EOD;
        return PHP_EOL.sprintf($templateGetter, $fieldName, $type, $getterName, $fieldName).PHP_EOL;
    }

    public function getInitialize(array $pieces)
    {
        $templateInitialize = <<<EOD
    /**
     * Initialize method for model.
     */
    public function initialize()
    {
%s
    }
EOD;
        return PHP_EOL.sprintf($templateInitialize, rtrim(join('', $pieces))).PHP_EOL;
    }

    public function getModelFind($className)
    {
        $templateFind = <<<EOD
    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed \$parameters
     * @return %s[]|%s|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find(\$parameters = null): \Phalcon\Mvc\Model\ResultsetInterface
    {
        return parent::find(\$parameters);
    }
EOD;
        return PHP_EOL.sprintf($templateFind, $className, $className).PHP_EOL;
    }

    public function getModelFindFirst($className)
    {
        $templateFind = <<<EOD
    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed \$parameters
     * @return %s|\Phalcon\Mvc\Model\ResultInterface|\Phalcon\Mvc\ModelInterface|null
     */
    public static function findFirst(\$parameters = null): ?\Phalcon\Mvc\ModelInterface
    {
        return parent::findFirst(\$parameters);
    }
EOD;
        return PHP_EOL.sprintf($templateFind, $className, $className).PHP_EOL;
    }

    /**
     * Builds a PHP syntax with all the options in the array
     *
     * @param  array  $options
     * @return string PHP syntax
     */
    public function getRelationOptions(array $options = null)
    {
        if (empty($options)) {
            return 'NULL';
        }

        $values = [];
        foreach ($options as $name => $val) {
            if (is_bool($val)) {
                $val = $val ? 'true':'false';
            } elseif (!is_numeric($val)) {
                $val = "'{$val}'";
            }

            $values[] = sprintf('\'%s\' => %s', $name, $val);
        }

        return '['. join(',', $values). ']';
    }

    /**
     * @param \Phalcon\Db\ColumnInterface[] $fields
     * @param bool                 $camelize
     * @return string
     */
    public function getColumnMap($fields, $camelize = false)
    {
        $template = <<<EOD
    /**
     * Independent Column Mapping.
     * Keys are the real names in the table and the values their names in the application
     *
     * @return array
     */
    public function columnMap()
    {
        return [
            %s
        ];
    }
EOD;

        $contents = [];
        foreach ($fields as $field) {
            $name = $field->getName();
            $contents[] = sprintf('\'%s\' => \'%s\'', $name, $camelize ? Utils::lowerCamelize($name) : $name);
        }

        return PHP_EOL.sprintf($template, join(",\n            ", $contents)).PHP_EOL;
    }

    public function getMigrationMorph($className, $table, $tableDefinition)
    {
        $template = <<<EOD
use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Mvc\Model\Migration;

/**
 * Class %s
 */
class %s extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        \$this->morphTable('%s', [
%s
EOD;
        return sprintf($template, $className, $className, $table, $this->getMigrationDefinition('columns', $tableDefinition));
    }

    public function getMigrationUp()
    {
        return <<<EOD

    /**
     * Run the migrations
     *
     * @return void
     */
    public function up()
    {

EOD;
    }

    public function getMigrationDown()
    {
        return <<<EOD

    /**
     * Reverse the migrations
     *
     * @return void
     */
    public function down()
    {

EOD;
    }

    public function getMigrationBatchInsert($table, $allFields)
    {
        $template = <<<EOD
        \$this->batchInsert('%s', [
                %s
            ]
        );
EOD;
        return sprintf($template, $table, join(",\n                ", $allFields));
    }

    public function getMigrationAfterCreateTable($table, $allFields)
    {
        $template = <<<EOD

    /**
     * This method is called after the table was created
     *
     * @return void
     */
     public function afterCreateTable()
     {
        \$this->batchInsert('%s', [
                %s
            ]
        );
     }
EOD;
        return sprintf($template, $table, join(",\n                ", $allFields));
    }

    public function getMigrationBatchDelete($table)
    {
        $template = <<<EOD
        \$this->batchDelete('%s');
EOD;
        return sprintf($template, $table);
    }

    public function getMigrationDefinition(string $name, $definition)
    {
        $template = <<<EOD
                '%s' => [
                    %s
                ],

EOD;
        return sprintf($template, $name, join(",\n                    ", $definition));
    }

    public function getColumnDefinition($field, $fieldDefinition)
    {
        $template = <<<EOD
new Column(
                        '%s',
                        [
                            %s
                        ]
                    )
EOD;

        return sprintf($template, $field, join(",\n                            ", $fieldDefinition));
    }

    public function getIndexDefinition($indexName, $indexDefinition, $indexType = null)
    {
        $template = <<<EOD
new Index('%s', [%s], %s)
EOD;

        return sprintf($template, $indexName, join(", ", $indexDefinition), $indexType ? "'$indexType'" : 'null');
    }

    public function getReferenceDefinition($constraintName, $referenceDefinition)
    {
        $template = <<<EOD
new Reference(
                        '%s',
                        [
                            %s
                        ]
                    )
EOD;

        return sprintf($template, $constraintName, join(",\n                            ", $referenceDefinition));
    }

    public function getUse($class)
    {
        $templateUse = 'use %s;';

        return sprintf($templateUse, $class);
    }

    public function getUseAs($class, $alias)
    {
        $templateUseAs = 'use %s as %s;';

        return sprintf($templateUseAs, $class, $alias);
    }

    public function getThisMethod($method, $params)
    {
        $templateThis = "        \$this->%s(%s);" . PHP_EOL;

        return sprintf($templateThis, $method, '"' . $params . '"');
    }

    public function getRelation($relation, $column1, $entity, $column2, $alias)
    {
        $templateRelation = "        \$this->%s('%s', '%s', '%s', %s);" . PHP_EOL;

        return sprintf($templateRelation, $relation, $column1, $entity, $column2, $alias);
    }
}
