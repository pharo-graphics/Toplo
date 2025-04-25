Trait {
	#name : #TToMenuItemContainer,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item element container' }
TToMenuItemContainer >> collectedNodesDo: aValuable [

	self allChildrenBreadthFirstDo: [ :child |
		(child isKindOf: ToMenuItemNode) ifTrue: [
			child isFake ifFalse: [ aValuable value: child ] ] ]
]
