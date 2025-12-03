Class {
	#name : #ToMultiSelectInnerBarElement,
	#superclass : #ToInnerBarElement,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - bar element' }
ToMultiSelectInnerBarElement >> onInvisibleNodeContainers: theInvisibleContainers visibleNodeContainers: theVisibleContainers [

	| theVisibles theInvisibles summary finalCount |
	listElement isFlowable ifTrue: [ ^ self ].
	listElement isScrollable ifTrue: [ ^ self ].
	theInvisibleContainers ifEmpty: [ ^ self ].
	" in case of composite node at first it means that 
	there is no more visible node to cumulate in a composite node"
	self nodeContainers size = 1 ifTrue: [ ^ self ].
	theVisibles := theVisibleContainers copy.
	theInvisibles := theInvisibleContainers copy.
	theVisibles ifNotEmpty: [
		"theInvisibles := theInvisibleContainers copyWith: theVisibles last.
		theVisibles := theVisibles copyWithout: theVisibles last" ].
	" now cover the last visible node with a summary of invisible nodes  "
	"summary := ToMultiSelectSummaryTagElement new.
	summary invisibleItems: (Array streamContents: [ :stream |
			 invisibleNodes do: [ :n |
				 stream nextPutAll: n holder dataItem items ] ])."
"	finalCount := listElement nodesCount - theInvisibles size."
	"composite content: '+ ' , finalCount asString , ' ...'."
	theInvisibles reverseDo: [ :container |
		listElement dataAccessor removeAt: container holder position ].
	"listElement dataAccessor add: composite"
]
