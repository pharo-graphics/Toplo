Extension { #name : #ToElement }

{ #category : #'*Toplo-Widget-Pane' }
ToElement >> inHorizontalPane [

	| pane |
	pane := ToPane horizontal.
	pane addChild: self.
	^ pane
]

{ #category : #'*Toplo-Widget-Pane' }
ToElement >> inVerticalPane [

	| pane |
	pane := ToPane vertical.
	pane addChild: self.
	^ pane
]

{ #category : #'*Toplo-Widget-Pane' }
ToElement >> newScrollable [

	^ ToScrollableElement new
]
