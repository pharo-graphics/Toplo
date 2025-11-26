Class {
	#name : #ToTableListCellContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'event handling' }
ToTableListCellContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| columnState listElement |
			listElement := e tableNodeHolder listElement.
			columnState := listElement columnStateAt: e columnIndex.
			columnState width ifNotNil: [ :w |
					e columnIndex = 1
						ifTrue: [
								| indent indentWidth |
								indent := e valueOfTokenNamed: #'node-indent'.
								indentWidth := indent * e nodeDepth.
								e width: w - indentWidth ]
						ifFalse: [ e width: w ] ] ]
]
