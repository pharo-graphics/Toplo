Class {
	#name : #ToMultiSelectHeaderInnerListElement,
	#superclass : #ToInnerFiniteListElement,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - bar element' }
ToMultiSelectHeaderInnerListElement >> onInvisibleNodeContainers: theInvisibleContainers visibleNodeContainers: theVisibleContainers [

	| nbInvisible |
	listElement isFlowable ifTrue: [ ^ self ].
	listElement isScrollable ifTrue: [ ^ self ].
	nbInvisible := self selectedDataItems size
	               - theVisibleContainers size.
	nbInvisible isZero ifTrue: [
			listElement invisibleNodesLabel text: ''.
			^ self ].
	self nodeContainers size = 1 ifTrue: [ ^ self ].
	theInvisibleContainers reverseDo: [ :container |
		listElement dataAccessor removeAt: container holder position ].
	listElement invisibleNodesLabel text:
		'+ ' , nbInvisible asString , ' ...'
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
