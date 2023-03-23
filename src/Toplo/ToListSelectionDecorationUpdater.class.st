Class {
	#name : #ToListSelectionDecorationUpdater,
	#superclass : #ToListDecorationUpdater,
	#category : #'Toplo-Widget-List'
}

{ #category : #'infinite element changes' }
ToListSelectionDecorationUpdater >> adjacentSelectedNodesGroupsIn: aListElement [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  aListElement infinite childrenDo: [ :node |
			  node holder isSelected
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #initialization }
ToListSelectionDecorationUpdater >> resetDecorations [ 

	"decorations do: [ :d | d cleanUpNodes ]."
	super resetDecorations
]

{ #category : #'infinite element changes' }
ToListSelectionDecorationUpdater >> selectionDecorationElementsIn: aListElement [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroupsIn: aListElement) collect: [ :g |
		  ToListSelectionDecorationElement new
			  listElement: aListElement;
			  nodes: g;
			  yourself ]
]

{ #category : #'infinite element changes' }
ToListSelectionDecorationUpdater >> updateDecorationsIn: aListElement [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	self resetDecorations.
	decorations addAll: (self selectionDecorationElementsIn: aListElement).
	aListElement addChildren: decorations
]

{ #category : #'infinite element changes' }
ToListSelectionDecorationUpdater >> updateSelectionBackground: aBackground [

	decorations do: [ :d |
		d background: aBackground ]
]
