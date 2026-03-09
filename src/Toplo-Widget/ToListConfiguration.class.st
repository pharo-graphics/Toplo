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
		'#exactNodeWidth => ObservableSlot',
		'#exactNodeHeight => ObservableSlot',
		'#rowNumbers => ObservableSlot',
		'#useScrollbar => ObservableSlot',
		'#scrollbar'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #hook }
ToListConfiguration >> applyOn: aListElement [ 

	super applyOn: aListElement.
	aListElement innerElement withRowNumbers: rowNumbers.
	self configureScrollbarIn: aListElement
]

{ #category : #accessing }
ToListConfiguration >> autoDistribute [

	^ autoDistribute 
]

{ #category : #accessing }
ToListConfiguration >> autoDistribute: anObject [

	autoDistribute := anObject 
]

{ #category : #initialization }
ToListConfiguration >> configureScrollbarIn: aListElement [

	aListElement haveInnerElement ifFalse: [
			^ aListElement postponeAction: [
				  self configureScrollbarIn: aListElement ] ].
	scrollbar ifNotNil: [
			scrollbar detach.
			scrollbar removeFromParent.
			scrollbar := nil.
			aListElement requestNewSkin ].
	useScrollbar ifFalse: [ ^ self ].

	scrollbar := ToScrollbarElement horizontal: aListElement isHorizontal.
	scrollbar
		addEventHandlerOn: BlElementVisibilityChangedEvent
		do: [ :evt | aListElement requestNewSkin ].
	scrollbar attachTo: aListElement innerElement.
	scrollbar elevation: (BlRelativeElevation elevation: 20).
	aListElement addChild: scrollbar.
	aListElement requestNewSkin
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

{ #category : #testing }
ToListConfiguration >> haveVisibleScrollbar [

	^ scrollbar notNil and: [ scrollbar isVisible ]
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

	useCheckbox := false.
	rowNumbers := false.
	autoDistribute := false.
	isFlowable := false.
	isScrollable := true.
	useScrollbar := false.

	self
		property: #useCheckbox
		whenChangedDo: [
		aListElement dispatchEvent: ToListCheckableNodeUseChanged new ].
	self
		property: #useScrollbar
		whenChangedDo: [ self configureScrollbarIn: aListElement ].

	#( #autoDistribute #isFlowable #isScrollable #rowNumbers ) do: [
			:flag |
			self
				property: flag
				whenChangedDo: [ aListElement requestConfiguration ] ].
	#( #exactNodeWidth #exactNodeHeight ) do: [ :flag |
			self property: flag whenChangedDo: [
				aListElement postponeAction: [
					aListElement notifyDataSourceChanged ] ] ]
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
ToListConfiguration >> useCheckbox [ 

	^ useCheckbox
]

{ #category : #accessing }
ToListConfiguration >> useCheckbox: aBoolean [

	useCheckbox := aBoolean
]

{ #category : #accessing }
ToListConfiguration >> useScrollbar [

	^ useScrollbar
]

{ #category : #accessing }
ToListConfiguration >> useScrollbar: anObject [

	useScrollbar := anObject
]
