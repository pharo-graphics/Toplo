Class {
	#name : #ToTreeNodeContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'event handling' }
ToTreeNodeContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| w interspace indent |
			interspace := e valueOfTokenNamed: #'node-interspace'.
			indent := e valueOfTokenNamed: #'node-indent'.
			w := e nodeDepth * indent.
			e arrowButton ifNotNil: [ :arrowButton |
					| wrapper |
					wrapper := e holder dataWrapper.
					"Avoid styling on fake data that can execute code for nothing"
					(e holder itemElement isFake not and: [ wrapper hasLeafDataItem ])
						ifTrue: [ arrowButton beNone ]
						ifFalse: [
								wrapper isExpanded
									ifFalse: [ arrowButton beRight ]
									ifTrue: [ arrowButton beDown ] ].
					e indentWidth: w.
					e startInterspace: interspace ] ]
]
