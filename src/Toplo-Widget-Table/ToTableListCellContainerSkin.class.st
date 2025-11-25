Class {
	#name : #ToTableListCellContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'event handling' }
ToTableListCellContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| columnIndex columnState indent indentWidth |
			indent := e valueOfTokenNamed: #'node-indent'.
			indentWidth := indent * e nodeDepth.
			columnIndex := e columnIndex.
			columnState := e tableNodeHolder listElement columnStateAt: columnIndex.
			columnState width ifNotNil: [ :w |
					columnIndex = 1
						ifTrue: [ e width: w - indentWidth ]
						ifFalse: [ e width: w ] ] ]
]
