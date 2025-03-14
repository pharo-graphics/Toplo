Trait {
	#name : #TToListElementEventHandler,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - list element event handler' }
TToListElementEventHandler >> withTargetNodeFromEvent: anEvent do: aValuable [
	" crappy but useful to get the node from the position of the event.
	I'm used for selecting node and for context menu opening in case list node have margin"

	| globalPosition currTarget childNode |
	globalPosition := anEvent position.
	currTarget := anEvent currentTarget.
	childNode := currTarget nodes
		             detect: [ :node |
			             node holder isSelectable and: [
				             node containsGlobalPoint: globalPosition ] ]
		             ifNone: [
			             currTarget innerElement nodes
				             detect: [ :node |
					             | gap |
					             gap := currTarget isHorizontal
						                    ifTrue: [ node margin left ]
						                    ifFalse: [ node margin top ].
					             node holder isSelectable and: [
						             node containsGlobalPoint:
							             globalPosition - (0 @ gap) ] ]
				             ifNone: [
					             currTarget innerElement nodes
						             detect: [ :node |
							             | gap |
							             gap := currTarget isHorizontal
								                    ifTrue: [ node margin right ]
								                    ifFalse: [ node margin bottom ].
							             node holder isSelectable and: [
								             node containsGlobalPoint:
									             globalPosition + (0 @ gap) ] ]
						             ifNone: [  ] ] ].

	childNode ifNotNil: [ aValuable value: childNode ]
]
