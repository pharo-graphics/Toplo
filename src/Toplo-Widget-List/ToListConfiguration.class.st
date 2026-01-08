Class {
	#name : #ToListConfiguration,
	#superclass : #ToWidgetConfiguration,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#useCheckbox => ObservableSlot',
		'#autoDistribute => ObservableSlot',
		'#isFlowable => ObservableSlot',
		'#isScrollable => ObservableSlot',
		'#uniformNodeWidth => ObservableSlot',
		'#uniformNodeHeight => ObservableSlot',
		'#exactNodeWidth => ObservableSlot',
		'#exactNodeHeight => ObservableSlot',
		'#rowNumbers => ObservableSlot'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #hook }
ToListConfiguration >> applyOn: aListElement [ 

	super applyOn: aListElement.
	aListElement innerElement withRowNumbers: rowNumbers
]

{ #category : #accessing }
ToListConfiguration >> autoDistribute [

	^ autoDistribute 
]

{ #category : #accessing }
ToListConfiguration >> autoDistribute: anObject [

	autoDistribute := anObject 
]

{ #category : #'node configuration' }
ToListConfiguration >> configureNode: aNode [

	exactNodeWidth ifNotNil: [ :w | aNode hExact: w ].
	exactNodeHeight ifNotNil: [ :h | aNode vExact: h ].

	aNode isHExact ifFalse: [ aNode hMatchParent ].
	aNode isVExact ifFalse: [ aNode vMatchParent ]
]

{ #category : #'node configuration' }
ToListConfiguration >> configureNodeContainer: aNodeContainer [

	| listElement |
	listElement := aNodeContainer holder listElement.

	(listElement useInfiniteLayout not and: [ isFlowable ]) ifTrue: [
		^ aNodeContainer exactOrFitContent ].

	listElement isVertical ifTrue: [
			aNodeContainer hFitParent: listElement.
			(listElement useInfiniteLayout not and: [ autoDistribute ])
				ifTrue: [ aNodeContainer vMatchParent ]
				ifFalse: [ aNodeContainer vExactOrFitContent ].
			^ self ].

	" horizontal case "
	aNodeContainer vFitParent: listElement.
	(listElement useInfiniteLayout not and: [ autoDistribute ])
		ifTrue: [ aNodeContainer hMatchParent ]
		ifFalse: [ aNodeContainer hExactOrFitContent ]
]

{ #category : #accessing }
ToListConfiguration >> exactNodeHeight [

	^ exactNodeHeight 
]

{ #category : #accessing }
ToListConfiguration >> exactNodeHeight: aNumber [

	exactNodeHeight := aNumber
]

{ #category : #accessing }
ToListConfiguration >> exactNodeWidth [

	^ exactNodeWidth
]

{ #category : #accessing }
ToListConfiguration >> exactNodeWidth: aNumber [

	exactNodeWidth := aNumber
]

{ #category : #initialization }
ToListConfiguration >> initialize [

	super initialize.
	self class initializeSlots: self

]

{ #category : #accessing }
ToListConfiguration >> isFlowable [

	^ isFlowable 
]

{ #category : #accessing }
ToListConfiguration >> isFlowable: anObject [

	isFlowable := anObject 
]

{ #category : #accessing }
ToListConfiguration >> isScrollable [

	^ isScrollable 
]

{ #category : #accessing }
ToListConfiguration >> isScrollable: anObject [

	isScrollable := anObject 
]

{ #category : #hook }
ToListConfiguration >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.

	self property: #useCheckbox whenChangedDo: [
			aListElement inUIProcessDo: [
					aListElement nodeManager checkableNode: useCheckbox.
					aListElement onUseCheckboxChangedWith: useCheckbox ] ].
			
	#( #uniformNodeWidth #uniformNodeHeight #autoDistribute
	   #isFlowable #isScrollable #rowNumbers ) do: [ :flag |
			self
				property: flag
				whenChangedDo: [ aListElement requestConfiguration ] ].
	#( #exactNodeWidth #exactNodeHeight ) do: [ :flag |
			self
				property: flag
				whenChangedDo: [
				aListElement postponeAction: [ aListElement listElement notifyDataSourceChanged ] ] ].

	rowNumbers := false.
	uniformNodeWidth := false.
	uniformNodeHeight := false.
	autoDistribute := false.
	isFlowable := false.
	isScrollable := true
]

{ #category : #accessing }
ToListConfiguration >> rowNumbers [

	^ rowNumbers
]

{ #category : #accessing }
ToListConfiguration >> rowNumbers: aBoolean [

	rowNumbers := aBoolean
]

{ #category : #accessing }
ToListConfiguration >> uniformNodeHeight [

	^ uniformNodeHeight 
]

{ #category : #accessing }
ToListConfiguration >> uniformNodeHeight: anObject [

	uniformNodeHeight := anObject 
]

{ #category : #accessing }
ToListConfiguration >> uniformNodeWidth [

	^ uniformNodeWidth 
]

{ #category : #accessing }
ToListConfiguration >> uniformNodeWidth: anObject [

	uniformNodeWidth := anObject 
]

{ #category : #accessing }
ToListConfiguration >> useCheckbox [ 

	^ useCheckbox
]

{ #category : #accessing }
ToListConfiguration >> useCheckbox: aBoolean [

	useCheckbox := aBoolean
]
