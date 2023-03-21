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

{ #category : #'as yet unclassified' }
ToListSelectionDecorationUpdater >> adjacentSelectedNodesGroupsMergedBoundsFrom: adjacentSelectedNodesGroupList [

	" returns an array of bounds. Each bounds is the merge bound of a group of adjacent selected node "
	^ Array streamContents: [:stream |
		adjacentSelectedNodesGroupList do: [ :currGroup |
		| top bottom |
		top := currGroup first bounds inSpace bounds.
		currGroup first globalBoundsToLocal: top.
		currGroup first localBoundsToParent: top.
		top expandBy: (BlInsets left: currGroup first margin left right: currGroup first margin right).
		currGroup size = 1
			ifTrue: [ bottom := top ]
			ifFalse: [
				bottom := currGroup last bounds inSpace bounds.
				currGroup last globalBoundsToLocal: bottom.
				currGroup last localBoundsToParent: bottom.
				bottom expandBy: (BlInsets left: currGroup last margin left right: currGroup last margin right).].
		
		stream nextPut: (BlBounds origin: top position  corner: bottom corner) ] ]
]

{ #category : #initialization }
ToListSelectionDecorationUpdater >> resetDecorations [ 

	decorations do: [ :d | d cleanUpNodes ].
	super resetDecorations
]

{ #category : #'infinite element changes' }
ToListSelectionDecorationUpdater >> selectionDecorationElementsIn: aListElement [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroupsIn: aListElement) collect: [ :g |
		  ToListSelectionDecorationElement new
			  listElement: aListElement;
			  adjacentNodes: g;
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
		d background: aBackground.
		d changedSelectionBackground ]
]
