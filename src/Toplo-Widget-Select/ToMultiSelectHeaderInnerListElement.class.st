Class {
	#name : #ToMultiSelectHeaderInnerListElement,
	#superclass : #ToInnerFiniteListElement,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - bar element' }
ToMultiSelectHeaderInnerListElement >> onInvisibleNodeContainers: theInvisibleContainers visibleNodeContainers: theVisibleContainers [

	| nbInvisible first last |
	super
		onInvisibleNodeContainers: theInvisibleContainers
		visibleNodeContainers: theVisibleContainers.
	listElement toConfiguration isFlowable ifTrue: [ ^ self ].
	listElement toConfiguration isScrollable ifTrue: [ ^ self ].
	nbInvisible := self selectedDataItems size
	               - theVisibleContainers size.
	nbInvisible isZero ifTrue: [
			listElement invisibleNodesCommentElement invisibleCount: 0.
			^ self ].
	self nodeContainers size = 1 ifTrue: [ ^ self ].
	theInvisibleContainers ifEmpty: [ ^ self ].
	first := theInvisibleContainers first holder position.
	last := theInvisibleContainers last holder position.
	listElement dataAccessor removeFrom: first to: last.
	listElement invisibleNodesCommentElement invisibleCount: nbInvisible
]

{ #category : #'hooks - layout' }
ToMultiSelectHeaderInnerListElement >> onLayoutDone [ 

	super onLayoutDone.
	listElement selectElement checkMaxSelectedCountInHeader
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderInnerListElement >> selectElement [

	^ listElement selectElement
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderInnerListElement >> selectedDataItems [

	^ self  selectElement selectedDataItems
]
