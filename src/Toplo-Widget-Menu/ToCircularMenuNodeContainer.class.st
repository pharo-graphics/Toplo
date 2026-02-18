Class {
	#name : #ToCircularMenuNodeContainer,
	#superclass : #ToAnnulusSectorElement,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #accessing }
ToCircularMenuNodeContainer >> holder: anHolder [

	super holder: anHolder.
	node := ToCircularMenuNode new.
	node holder: anHolder.
	node constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add:
				(c anchors centerAnchor on: c anchors parent centroidAnchor) ].
	self addChild: node
]

{ #category : #'instance creation' }
ToCircularMenuNodeContainer >> newRawSkin [ 

	^ ToCircularMenuNodeContainerSkin new
]

{ #category : #accessing }
ToCircularMenuNodeContainer >> node [ 

	^ node
]
