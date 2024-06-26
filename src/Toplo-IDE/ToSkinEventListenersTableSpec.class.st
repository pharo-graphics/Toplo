Class {
	#name : #ToSkinEventListenersTableSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'table',
		'skin'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToSkinEventListenersTableSpec >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  add: self table;
		  yourself
]

{ #category : #defaults }
ToSkinEventListenersTableSpec >> iconForEventListener: anEventListener [

	self skin ifNil: [ ^ self iconNamed: #blank ].
	(self skin isKindOf: ToStyleSheetSkin)
		ifFalse: [ ^ self iconNamed: #blank ].
	^ (self skin skinEventListeners includes: anEventListener)
		  ifTrue: [ ^ self iconNamed: #smallOk ]
		  ifFalse: [ ^ self iconNamed: #smallCancel ]
]

{ #category : #'initialization - deprecated' }
ToSkinEventListenersTableSpec >> initializePresenter [

	table := SpTablePresenter new
		         beResizable;
		         sortingBlock: [ :a :b |
			         a eventClass name < b eventClass name ];
		         addColumn: ((SpStringTableColumn
				           title: ''
				           evaluated: [ :each | self iconForEventListener: each ])
				          width: 20);
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
		         yourself.
	table contextMenu: (SpMenuPresenter new addItem: [ :item |
			 item
				 name: 'Inspect the look event listener';
				 icon: (self iconNamed: #smallInspectIt);
				 action: [ self table selectedItem inspect ] ])
]

{ #category : #accessing }
ToSkinEventListenersTableSpec >> skin [

	^ skin
]

{ #category : #accessing }
ToSkinEventListenersTableSpec >> skin: aSkin [

	skin := aSkin
]

{ #category : #accessing }
ToSkinEventListenersTableSpec >> skinEventListeners: aCollection [

	self table items: aCollection
]

{ #category : #accessing }
ToSkinEventListenersTableSpec >> table [

	^ table
]
