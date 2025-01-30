Trait {
	#name : #TToMenuItemElementContainer,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item element container' }
TToMenuItemElementContainer >> collectedNodesDo: aValuable [

	self allChildrenBreadthFirstDo: [ :child |
		(child isKindOf: ToMenuItemNode) ifTrue: [
			child isFake ifFalse: [ aValuable value: child ] ] ]
]
