Class {
	#name : #ToBasicFiniteListElementConfiguration,
	#superclass : #ToBasicListElementConfiguration,
	#instVars : [
		'#autoDistribute => ObservableSlot',
		'#isFlowable => ObservableSlot',
		'#isScrollable => ObservableSlot',
		'#uniformNodeWidth => ObservableSlot',
		'#uniformNodeHeight => ObservableSlot'
	],
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> autoDistribute [

	^ autoDistribute 
]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> autoDistribute: aBoolean [

	autoDistribute := aBoolean 
]

{ #category : #hook }
ToBasicFiniteListElementConfiguration >> defaultInnerElementClass [

	^ ToInnerFiniteListElement  
]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> isFlowable [

	^ isFlowable ifNil: [ isFlowable := true ] 
]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> isFlowable: aBoolean [

	isFlowable := aBoolean 
]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> isScrollable [

	^ isScrollable ifNil: [ isScrollable := false ] 
]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> isScrollable: aBoolean [

	isScrollable := aBoolean 
]

{ #category : #'accessing - fake container' }
ToBasicFiniteListElementConfiguration >> newFakeNodeContainer [ 

	^ ToFiniteListFakeNodeContainer new 
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

{ #category : #'accessing - fake container' }
ToBasicFiniteListElementConfiguration >> reinstallFakeNodeContainerIn: aListElement [

	(aListElement hasChildren and: [ aListElement firstChild isFake ])
		  ifTrue: [ aListElement firstChild removeFromParent].
	self installFakeNodeContainerIn: aListElement
]

{ #category : #'accessing - fake container' }
ToBasicFiniteListElementConfiguration >> removeFakeNodeContainerFrom: aListElement [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	(aListElement hasChildren and: [ aListElement firstChild isFake ])
		  ifTrue: [ aListElement firstChild removeFromParent].

]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> uniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ] 
]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> uniformNodeHeight: aBoolean [

	uniformNodeHeight := aBoolean
]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ] 
]

{ #category : #accessing }
ToBasicFiniteListElementConfiguration >> uniformNodeWidth: aBoolean [

	uniformNodeWidth := aBoolean
]
