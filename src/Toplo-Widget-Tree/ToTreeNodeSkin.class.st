Class {
	#name : #ToTreeNodeSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Widget-Tree-Skin'
}

{ #category : #'as yet unclassified' }
ToTreeNodeSkin >> indentElementForWrapper: aWrapper [ 

	^ aWrapper isLeaf
		       ifTrue: [ self nodeLeafElement  ]
		       ifFalse: [
			       aWrapper isCollapsed
					        ifTrue: [
					        self nodeCollapsedElement ]
					        ifFalse: [
					        self nodeExpandedElement ] ]
]

{ #category : #'event handling' }
ToTreeNodeSkin >> installSkinEvent: anEvent [ 

	| elt wrapper |
	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		wrapper := e holder dataWrapper.
		elt := self indentElementForWrapper: wrapper.
		elt size: 20 asPoint; margin: (BlInsets left: 20 * (wrapper nodeDepth - 1)).
		elt addEventHandlerOn: BlClickEvent do: [ :event |
		  event consume.
		  e holder click.
		  e listElementDo: #notifyDataSourceChanged ].
		e firstChild startElement: elt. ]
	
]

{ #category : #'as yet unclassified' }
ToTreeNodeSkin >> nodeCollapsedElement [

	^ BlSvgConverter convertFromString: ToMaterialDesignIconProvider outlined_keyboardarrowright
]

{ #category : #'as yet unclassified' }
ToTreeNodeSkin >> nodeExpandedElement [

	^ BlSvgConverter convertFromString: ToMaterialDesignIconProvider outlined_keyboardarrowdown
]

{ #category : #'as yet unclassified' }
ToTreeNodeSkin >> nodeLeafElement [

	^ BlElement new background: Color transparent
]
