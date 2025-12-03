Class {
	#name : #ToMultiSelectInnerFiniteListElement,
	#superclass : #ToInnerFiniteListElement,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - bar element' }
ToMultiSelectInnerFiniteListElement >> onInvisibleNodeContainers: theInvisibleNodes visibleNodeContainers: theVisibleNodes [

	| visibleNodes invisibleNodes composite finalCount |
	listElement isFlowable ifTrue: [ ^ self ].
	listElement isScrollable ifTrue: [ ^ self ].
	theInvisibleNodes ifEmpty: [ ^ self ].
	" in case of composite node at first it means that 
	there is no more visible node to cumulate in a composite node"
	self nodeContainers size = 1 ifTrue: [ ^ self ].
	visibleNodes := theVisibleNodes copy.
	invisibleNodes := theInvisibleNodes copy.
	visibleNodes ifNotEmpty: [
		invisibleNodes := theInvisibleNodes copyWith: visibleNodes last.
		visibleNodes := visibleNodes copyWithout: visibleNodes last ].
	" now cumulate invisible nodes in a composite tag model "
	composite := ToCompositeTag new.
	composite items: (Array streamContents: [ :stream |
			 invisibleNodes do: [ :n |
				 stream nextPutAll: n holder dataItem items ] ]).
	finalCount := listElement nodesCount - visibleNodes size.
	composite content: '+ ' , finalCount asString , ' ...'.
	invisibleNodes do: [ :node |
		listElement dataAccessor removeAt: node holder position ].
	listElement dataAccessor add: composite
]
