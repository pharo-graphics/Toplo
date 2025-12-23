Class {
	#name : #ToBasicFiniteListElementConfiguration,
	#superclass : #ToBasicListElementConfiguration,
	#traits : 'TToBasicFiniteListElementConfiguration',
	#classTraits : 'TToBasicFiniteListElementConfiguration classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #configuration }
ToBasicFiniteListElementConfiguration >> configureNodeContainer: aNodeContainer inLisElement: aListElement [

	self isFlowable
		ifTrue: [ aNodeContainer fitContent ]
		ifFalse: [
				aListElement isVertical 
					ifTrue: [
							aListElement isHMatchParent
								ifTrue: [ aNodeContainer hMatchParent ]
								ifFalse: [ aNodeContainer hFitContent ].
							self autoDistribute
								ifTrue: [ aNodeContainer vMatchParent ]
								ifFalse: [ aNodeContainer vFitContent ] ]
					ifFalse: [
							aListElement isVMatchParent
								ifTrue: [ aNodeContainer vMatchParent ]
								ifFalse: [ aNodeContainer vFitContent ].
							self autoDistribute
								ifTrue: [ aNodeContainer hMatchParent ]
								ifFalse: [ aNodeContainer hFitContent ] ] ]
]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> defaultInnerElementClass [

	^ ToInnerFiniteListElement  
]

{ #category : #initialization }
ToBasicFiniteListElementConfiguration >> initialize [

	super initialize.
	self class initializeSlots: self
]

{ #category : #hook }
ToBasicFiniteListElementConfiguration >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	#( #uniformNodeWidth #uniformNodeHeight #autoDistribute
	   #isFlowable #isScrollable ) do: [ :flag |
			self
				property: flag
				whenChangedDo: [ aListElement requestConfiguration ] ].
	uniformNodeWidth := false.
	uniformNodeHeight := false.
	autoDistribute := false.
	isFlowable := true.
	isScrollable := false

]
