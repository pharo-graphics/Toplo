Class {
	#name : #ToMenuFiniteListFlowLayout,
	#superclass : #ToFiniteListFlowLayout,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #measure }
ToMenuFiniteListFlowLayout >> measure: anElement with: anExtentSpec [

	| menuBarOwner |
	menuBarOwner := anElement listElement menuBarOwner.
	" in case of an inline menu, the item minWidth is forced to be its menuBarOwner width"
	menuBarOwner hasInlineWindow ifTrue: [
		self minNodeWidth: menuBarOwner measuredWidth ].
	super measure: anElement with: anExtentSpec
]
