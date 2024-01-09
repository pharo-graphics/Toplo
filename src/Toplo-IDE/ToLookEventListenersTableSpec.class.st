Class {
	#name : #ToLookEventListenersTableSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'table'
	],
	#category : #'Toplo-IDE'
}

{ #category : #layout }
ToLookEventListenersTableSpec >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  add: self table;
		  yourself
]

{ #category : #'initialization - deprecated' }
ToLookEventListenersTableSpec >> initializePresenter [

	table := SpTablePresenter new
		         beResizable;
		sortingBlock: [ :a :b | a eventClass name < b eventClass name];
		         addColumn:
			         ((SpStringTableColumn
				           title: 'Supplement'
				           evaluated: [ :each |
					           each isSupplement
						           ifTrue: [ 'True' ]
						           ifFalse: [ 'False' ] ]) width: 80);
		         addColumn: ((SpStringTableColumn
				           title: 'Look Event Class'
				           evaluated: [ :each | each eventClass name ]) width: 100);
		         addColumn: (SpStringTableColumn
				          title: 'Property'
				          evaluated: [ :each | each property name ]);
		         addColumn: (SpStringTableColumn
				          title: 'Value'
				          evaluated: [ :each | each value printString ]);
		         addColumn: ((SpStringTableColumn
				           title: 'Animation'
				           evaluated: [ :each | each animation printString ])
				          width: 80);
		         yourself
]

{ #category : #accessing }
ToLookEventListenersTableSpec >> lookEventListeners: aCollection [

	self table items: aCollection
]

{ #category : #accessing }
ToLookEventListenersTableSpec >> properties: aCollectionOfProperties [

	self table items: aCollectionOfProperties
]

{ #category : #accessing }
ToLookEventListenersTableSpec >> table [

	^ table
]
