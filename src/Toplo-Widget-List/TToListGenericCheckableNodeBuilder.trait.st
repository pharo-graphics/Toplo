Trait {
	#name : #TToListGenericCheckableNodeBuilder,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - list generic checkable node builder' }
TToListGenericCheckableNodeBuilder >> buildCheckableNode: aNode [

	| innerElement listElement cbox |
	listElement := aNode holder listElement.
	cbox := listElement newCheckboxInNode: aNode.
	innerElement := ToElement new
		                hMatchParent;
		                vFitContent.
	innerElement layout: BlLinearLayout horizontal.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	innerElement constraintsDo: [ :c | c linear vertical alignCenter ].
	aNode addChild: cbox.
	aNode addChild: innerElement.
	self nodeBuilder
		cull: innerElement
		cull: aNode holder dataItem
		cull: aNode holder
]

{ #category : #'t - list generic checkable node builder' }
TToListGenericCheckableNodeBuilder >> buildNode: aNode [

	self useCheckableNode ifTrue: [ ^ self buildCheckableNode: aNode ].
	self buildSimpleNode: aNode
]

{ #category : #'t - list generic checkable node builder' }
TToListGenericCheckableNodeBuilder >> buildSimpleNode: aNode [

	self nodeBuilder
		cull: aNode
		cull: aNode holder dataItem
		cull: aNode holder
]
