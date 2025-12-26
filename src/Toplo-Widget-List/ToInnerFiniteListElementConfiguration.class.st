Class {
	#name : #ToInnerFiniteListElementConfiguration,
	#superclass : #ToWidgetConfiguration,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#autoDistribute => ObservableSlot',
		'#isFlowable => ObservableSlot',
		'#isScrollable => ObservableSlot',
		'#uniformNodeWidth => ObservableSlot',
		'#uniformNodeHeight => ObservableSlot'
	],
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> autoDistribute [

	^ autoDistribute 
]

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> autoDistribute: anObject [

	autoDistribute := anObject 
]

{ #category : #initialization }
ToInnerFiniteListElementConfiguration >> initialize [

	super initialize.
	self class initializeSlots: self

]

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> isFlowable [

	^ isFlowable 
]

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> isFlowable: anObject [

	isFlowable := anObject 
]

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> isScrollable [

	^ isScrollable 
]

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> isScrollable: anObject [

	isScrollable := anObject 
]

{ #category : #hook }
ToInnerFiniteListElementConfiguration >> onInstalledIn: anInnerListElement [

	super onInstalledIn: anInnerListElement.

	#( #uniformNodeWidth #uniformNodeHeight #autoDistribute
	   #isFlowable #isScrollable ) do: [ :flag |
			self
				property: flag
				whenChangedDo: [ anInnerListElement requestConfiguration ] ].

	uniformNodeWidth := false.
	uniformNodeHeight := false.
	autoDistribute := false.
	isFlowable := false.
	isScrollable := true
]

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> uniformNodeHeight [

	^ uniformNodeHeight 
]

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> uniformNodeHeight: anObject [

	uniformNodeHeight := anObject 
]

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> uniformNodeWidth [

	^ uniformNodeWidth 
]

{ #category : #'t - inner finite list element configuration' }
ToInnerFiniteListElementConfiguration >> uniformNodeWidth: anObject [

	uniformNodeWidth := anObject 
]
