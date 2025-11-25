Class {
	#name : #ToTreeNodeContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'event handling' }
ToTreeNodeContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| w arrowIcon interspace indent |
			interspace := e valueOfTokenNamed: #'node-interspace'.
			indent := e valueOfTokenNamed: #'node-indent'.
			w := e nodeDepth * indent.
			arrowIcon := e startContainer childWithId: #arrowIcon ifNone: [ ].
			arrowIcon ifNotNil: [
					| wrapper |
					wrapper := e holder dataWrapper.
					wrapper hasLeafDataItem
						ifTrue: [ arrowIcon beNone ]
						ifFalse: [
								wrapper isExpanded
									ifFalse: [ arrowIcon beRight ]
									ifTrue: [ arrowIcon beDown ] ] ].
			e indentWidth: w.
			e startInterspace: interspace ]
]
