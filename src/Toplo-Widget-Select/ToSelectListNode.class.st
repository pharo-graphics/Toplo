Class {
	#name : #ToSelectListNode,
	#superclass : #ToNode,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToSelectListNode >> initialize [ 

	super initialize.
	self initializeForToplo.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #skin }
ToSelectListNode >> installRawStyle [

	| verticalPadding leftPadding rightPadding |
	super installRawStyle.
	verticalPadding := self valueOfTokenNamed: #'padding-content-V'.
	rightPadding := self valueOfTokenNamed: #'padding-content-H'.
	leftPadding := self valueOfTokenNamed: #'padding-content-H'.
	self isGroup ifTrue: [
		leftPadding := leftPadding / 2 ].
	self padding: (BlInsets
			 top: verticalPadding
			 left: leftPadding
			 bottom: verticalPadding
			 right: rightPadding)
]

{ #category : #accessing }
ToSelectListNode >> isGroup [

	^ self holder isGroup
]
