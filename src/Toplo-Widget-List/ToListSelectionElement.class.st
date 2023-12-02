Class {
	#name : 'ToListSelectionElement',
	#superclass : 'ToElement',
	#instVars : [
		'listElement',
		'nodes'
	],
	#category : 'Toplo-Widget-List-Core',
	#package : 'Toplo-Widget-List',
	#tag : 'Core'
}

{ #category : 'private' }
ToListSelectionElement >> boundsFromSelectedNodes [
	" compute my bounds from my list of adjacent nodes. "

	| first last top bottom |
	first := nodes first.
	last := nodes last.
	top := self boundsOfNode: first.
	bottom := first = last
		          ifTrue: [ top ]
		          ifFalse: [ self boundsOfNode: last ].
	^ BlBounds origin: top origin corner: bottom corner
]

{ #category : 'private' }
ToListSelectionElement >> boundsOfNode: aNode [
	" compute local node bounds "

	| bnds lpad tpad hgap vgap |
	bnds := (aNode bounds inSpace inChild: listElement) bounds.
	" expand to ensure a confortable context menu selection visual"
	listElement isVertical
		ifTrue: [
			lpad := listElement next padding left.
			tpad := listElement next padding top ]
		ifFalse: [
			lpad := aNode padding left.
			tpad := aNode padding top ].
	hgap := lpad > 0
		        ifTrue: [ lpad - 1 ]
		        ifFalse: [ 0 ].
	vgap := tpad > 0
		        ifTrue: [ 1 ]
		        ifFalse: [ 0 ].
	^ bnds expandBy: hgap @ vgap
]

{ #category : 'private' }
ToListSelectionElement >> computeBounds [
	" compute my bounds from my list of adjacent nodes. "

	self bounds: self boundsFromSelectedNodes
]

{ #category : 'initialization' }
ToListSelectionElement >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : 'accessing' }
ToListSelectionElement >> listElement [

	^ listElement
]

{ #category : 'accessing' }
ToListSelectionElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : 'accessing' }
ToListSelectionElement >> nodes [

	^ nodes
]

{ #category : 'accessing' }
ToListSelectionElement >> nodes: aCollection [

	nodes := aCollection.
	self computeBounds
]
