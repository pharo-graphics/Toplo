Class {
	#name : #ToListInnerElementConfiguration,
	#superclass : #ToWidgetConfiguration,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#autoDistribute => ObservableSlot',
		'#isFlowable => ObservableSlot',
		'#isScrollable => ObservableSlot',
		'#uniformNodeWidth => ObservableSlot',
		'#uniformNodeHeight => ObservableSlot',
		'#rowNumbers => ObservableSlot'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #hook }
ToListInnerElementConfiguration >> applyOn: aListInnerElement [ 

	super applyOn: aListInnerElement.
	aListInnerElement withRowNumbers: rowNumbers.
	aListInnerElement listElement forceUpdateAllSelectionsNow 
	
]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> autoDistribute [

	^ autoDistribute 
]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> autoDistribute: anObject [

	autoDistribute := anObject 
]

{ #category : #initialization }
ToListInnerElementConfiguration >> initialize [

	super initialize.
	self class initializeSlots: self

]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> isFlowable [

	^ isFlowable 
]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> isFlowable: anObject [

	isFlowable := anObject 
]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> isScrollable [

	^ isScrollable 
]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> isScrollable: anObject [

	isScrollable := anObject 
]

{ #category : #hook }
ToListInnerElementConfiguration >> onInstalledIn: anInnerListElement [

	super onInstalledIn: anInnerListElement.

	#( #uniformNodeWidth #uniformNodeHeight #autoDistribute
	   #isFlowable #isScrollable #rowNumbers ) do: [ :flag |
			self
				property: flag
				whenChangedDo: [ anInnerListElement requestConfiguration ] ].

	rowNumbers := false.
	uniformNodeWidth := false.
	uniformNodeHeight := false.
	autoDistribute := false.
	isFlowable := false.
	isScrollable := true
]

{ #category : #accessing }
ToListInnerElementConfiguration >> rowNumbers [

	^ rowNumbers
]

{ #category : #accessing }
ToListInnerElementConfiguration >> rowNumbers: aBoolean [

	rowNumbers := aBoolean
]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> uniformNodeHeight [

	^ uniformNodeHeight 
]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> uniformNodeHeight: anObject [

	uniformNodeHeight := anObject 
]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> uniformNodeWidth [

	^ uniformNodeWidth 
]

{ #category : #'t - inner finite list element configuration' }
ToListInnerElementConfiguration >> uniformNodeWidth: anObject [

	uniformNodeWidth := anObject 
]
