Class {
	#name : #ToLookEventListenersTableSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'table',
		'skin'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToLookEventListenersTableSpec >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  add: self table;
		  yourself
]

{ #category : #defaults }
ToLookEventListenersTableSpec >> iconForEventListener: anEventListener [

	self skin ifNil: [ ^ self iconNamed: #blank ].
	(self skin isKindOf: ToStyleSheetSkin)
		ifFalse: [ ^ self iconNamed: #blank ].
	^ (self skin lookEventListeners includes: anEventListener)
		  ifTrue: [ ^ self iconNamed: #smallOk ]
		  ifFalse: [ ^ self iconNamed: #smallCancel ]
]

{ #category : #'initialization - deprecated' }
ToLookEventListenersTableSpec >> initializePresenter [

	table := SpTablePresenter new
		         beResizable;
		         sortingBlock: [ :a :b |
			         a eventClass name < b eventClass name ];
		         addColumn: ((SpStringTableColumn
				           title: ''
				           evaluated: [ :each | self iconForEventListener: each ]) width: 20);
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
ToLookEventListenersTableSpec >> skin [

	^ skin
]

{ #category : #accessing }
ToLookEventListenersTableSpec >> skin: aSkin [

	skin := aSkin
]

{ #category : #accessing }
ToLookEventListenersTableSpec >> table [

	^ table
]
