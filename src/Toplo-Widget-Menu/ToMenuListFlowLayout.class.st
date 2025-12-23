Class {
	#name : #ToMenuListFlowLayout,
	#superclass : #ToFiniteListFlowLayout,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #measure }
ToMenuListFlowLayout >> measure: anElement with: anExtentSpec [

	| menuBarOwner |
	menuBarOwner := anElement listElement menuListOwner.
	" in case of an inline menu, the item minWidth is forced to be its menuBarOwner width"
	menuBarOwner hasInlineWindow ifTrue: [
		self minNodeWidth: menuBarOwner measuredWidth ].
	super measure: anElement with: anExtentSpec
]
