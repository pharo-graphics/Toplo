Class {
	#name : #ToListNodesDecorationUpdater,
	#superclass : #ToListDecorationUpdater,
	#category : #'Toplo-Widget-List'
}

{ #category : #private }
ToListNodesDecorationUpdater >> adjacentSelectedNodesGroupsIn: aListElement [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  aListElement infinite childrenDo: [ :node |
			  (self includesNode: node)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #'instance creation' }
ToListNodesDecorationUpdater >> includesNode: aNode [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToListNodesDecorationUpdater >> newDecorationElement [

	^ self subclassResponsibility 
]

{ #category : #private }
ToListNodesDecorationUpdater >> selectionDecorationElementsIn: aListElement [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroupsIn: aListElement) collect: [ :g |
		  self newDecorationElement
			  listElement: aListElement;
			  nodes: g;
			  yourself ]
]

{ #category : #'infinite element changes' }
ToListNodesDecorationUpdater >> updateDecorationsIn: aListElement [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	aListElement infinite requestLayout.
	aListElement infinite whenLayoutedDoOnce: [
		self resetDecorations.
		decorations addAll:
			(self selectionDecorationElementsIn: aListElement).
		aListElement addChildren: decorations ]
]
