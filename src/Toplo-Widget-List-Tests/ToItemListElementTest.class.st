"
A ToItemListElementTest is a test class for testing the behavior of ToItemListElement
"
Class {
	#name : #ToItemListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #tests }
ToItemListElementTest >> add1To10 [

	| n |
	self assert: l nodeContainers size equals: l dataAccessor size.
	self assert: (l nodeManager isKindOf: ToItemListNodeManager).

	space deferAndSettle: [ 
		l addAllItems:
			((1 to: 10) collect: [ :i | ToItemElementForTest new text: i asString ]) ].
	n := l nodes first.
	self assert: (n isKindOf: ToItemNodeForTest).
	self assert: (n holder isKindOf: ToItemListNodeHolderForTest).
	self assert: (n holder dataItem isKindOf: ToItemElementForTest)
]

{ #category : #tests }
ToItemListElementTest >> addAllItems [

	| bar |
	bar := l.
	space deferAndSettle: [ 
		bar addAllItems:
			((self statesOfAmerica ) collect: [ :v |
				 ToToggleButton labelText: v ]) ].
	bar nodeContainers withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ].
	bar nodeContainers withIndexDo: [ :it :idx |
			self assert: it holder position equals: idx.
			self assert: it node holder position equals: idx.
			self assert: it node item holder position equals: idx.
			self assert: (bar items at: idx) holder identicalTo: it holder.
			self assert: (bar items at: idx) holder position identicalTo: idx ].
	bar nodes withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ].
	bar nodeContainers do: [ :it |
		self assert: it holder identicalTo: it node holder ].
	bar nodeContainers do: [ :it |
		self assert: it holder identicalTo: it node item holder ].
	bar nodeContainers withIndexDo: [ :it :idx |
		self assert: it node item identicalTo: (bar items at: idx) ].
	1 to: self statesOfAmerica size do: [ :pos |
	self assert: (bar items at: pos) holder position equals: pos ].
	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToItemListElementTest >> addItem [

	| n item |
	item := ToItemElementForTest new text: '#1'.
	space deferAndSettle: [ l addItem: item ].
	self assert: l nodeContainers size equals: 1.
	n := l nodes first.
	self assert: (n isKindOf: ToItemNodeForTest).
	self assert: (n holder isKindOf: ToItemListNodeHolderForTest).
	self assert: (n holder dataItem isKindOf: ToItemElementForTest).
	self assert: item listElement identicalTo: l.
	self assert: item positionInList equals: 1
]

{ #category : #tests }
ToItemListElementTest >> disableItemAfterAdding [

	| n item |
	self assert: l nodeContainers size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	space deferAndSettle: [ 
		l addItem: item.
		item disable ].

	n := l nodes first.
	self assert: n holder dataItem identicalTo: item.
	self assert: item positionInList equals: 1.
	self assert:
		(l disabledSelectionModel containsIndex: item positionInList).
	self assert: item isDisabled.
	self assert: n isDisabled
]

{ #category : #tests }
ToItemListElementTest >> disableItemAfterAdding2 [

	| n item |
	self assert: l nodeContainers size equals: 0.

	space deferAndSettle: [ 
		item := ToItemElementForTest new text: 'A'.
		l addItem: item.
		item := ToItemElementForTest new text: 'B'.
		l addItem: item.
		item disable.
		item := ToItemElementForTest new text: 'C'.
		l addItem: item ].

	n := l nodes first.
	self assert: n item positionInList equals: 1.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled.

	n := l nodes second.
	space settle.
	self assert: n item positionInList equals: 2.
	self assert:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self assert: n item isDisabled.
	self assert: n isDisabled.

	n := l nodes third.
	self assert: n item positionInList equals: 3.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled
]

{ #category : #tests }
ToItemListElementTest >> disableItemBeforeAdding [

	| n item |
	self assert: l nodeContainers size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	space deferAndSettle: [ 
		item disabled: true.
		l addItem: item ].

	n := l nodes first.
	self assert: n holder dataItem identicalTo: item.
	self assert: item isDisabled.
	self assert: item positionInList equals: 1.
	self assert:
		(l disabledSelectionModel containsIndex: item positionInList).
	self assert: item isDisabled.
	self assert: n isDisabled
]

{ #category : #tests }
ToItemListElementTest >> disableItemBeforeAdding2 [

	| n item |
	self assert: l nodeContainers size equals: 0.

	space deferAndSettle: [ 
		item := ToItemElementForTest new text: 'A'.
		l addItem: item.
		item := ToItemElementForTest new text: 'B'.
		item disable.
		l addItem: item.
		item := ToItemElementForTest new text: 'C'.
		l addItem: item ].

	n := l nodes first.
	self assert: n item positionInList equals: 1.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled.

	space settle.
	n := l nodes second.
	self assert: n item positionInList equals: 2.
	self assert:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self assert: n item isDisabled.
	self assert: n isDisabled.

	n := l nodes third.
	self assert: n item positionInList equals: 3.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled
]

{ #category : #running }
ToItemListElementTest >> setUp [

	super setUp.
	l := ToItemListElementForTest new.
	l vMatchParent.
	space deferAndSettle: [ 
		space root addChild: l.
		l height: 30000 ].
]

{ #category : #accessing }
ToItemListElementTest >> statesOfAmerica [

	^ { #Alabama. #Alaska. #Arizona. #Arkansas. #California. #Colorado.
		#Connecticut. #Delaware. #Florida. #Georgia. #Hawaii. #Idaho. #Illinois. #Indiana.
		#Iowa. #Kansas. #Kentucky. #Louisiana. #Maine. #Maryland. #Massachusetts.
		#Michigan. #Minnesota. #Mississippi. #Missouri. #Montana. #Nebraska.
		#Nevada. #'New Hampshire'. #'New Jersey'. #'New Mexico'.
		#'New York'. #'North Carolina'. #'North Dakota'. #Ohio. #Oklahoma.
		#Oregon. #'Pennsylvania Rhode Island'. #'South Carolina'.
		#'South Dakota'. #Tennessee. #Texas. #Utah. #Vermont. #Virginia.
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }
]

{ #category : #tests }
ToItemListElementTest >> testFinite [

	space deferAndSettle: [ l useInfiniteLayout: false ].
	self add1To10 
]

{ #category : #tests }
ToItemListElementTest >> testFiniteAddAllItems [

	space deferAndSettle: [ l useInfiniteLayout: false ].
	self addAllItems
]

{ #category : #tests }
ToItemListElementTest >> testFiniteAddItem [

	space deferAndSettle: [ l useInfiniteLayout: false ].
	self addItem
]

{ #category : #tests }
ToItemListElementTest >> testFiniteDisableItemAfterAdding [

	space deferAndSettle: [ l useInfiniteLayout: false ].
	self disableItemAfterAdding
]

{ #category : #tests }
ToItemListElementTest >> testFiniteDisableItemAfterAdding2 [

	space deferAndSettle: [ l useInfiniteLayout: false ].
	self disableItemAfterAdding2
]

{ #category : #tests }
ToItemListElementTest >> testFiniteDisableItemBeforeAdding [

	space deferAndSettle: [ l useInfiniteLayout: false ].
	self disableItemBeforeAdding 
]

{ #category : #tests }
ToItemListElementTest >> testFiniteDisableItemBeforeAdding2 [

	space deferAndSettle: [ l useInfiniteLayout: false ].
	self disableItemBeforeAdding2
]

{ #category : #tests }
ToItemListElementTest >> testInfinite [

	space deferAndSettle: [ l useInfiniteLayout: true ].
	self add1To10
]

{ #category : #tests }
ToItemListElementTest >> testInfiniteAddAllItems [

	space deferAndSettle: [ l useInfiniteLayout: true ].
	self addAllItems
]

{ #category : #tests }
ToItemListElementTest >> testInfiniteAddItem [

	space deferAndSettle: [ l useInfiniteLayout: true ].
	self addItem
]

{ #category : #tests }
ToItemListElementTest >> testInfiniteDisableItemAfterAdding [

	space deferAndSettle: [ l useInfiniteLayout: true ].
	self disableItemAfterAdding
]

{ #category : #tests }
ToItemListElementTest >> testInfiniteDisableItemAfterAdding2 [

	space deferAndSettle: [ l useInfiniteLayout: true ].
	self disableItemAfterAdding2
]

{ #category : #tests }
ToItemListElementTest >> testInfiniteDisableItemBeforeAdding [

	space deferAndSettle: [ l useInfiniteLayout: true ].
	self disableItemBeforeAdding 
]

{ #category : #tests }
ToItemListElementTest >> testInfiniteDisableItemBeforeAdding2 [

	space deferAndSettle: [ l useInfiniteLayout: true ].
	self disableItemBeforeAdding2
]
