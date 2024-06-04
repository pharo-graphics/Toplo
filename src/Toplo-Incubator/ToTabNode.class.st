Class {
	#name : #ToTabNode,
	#superclass : #ToListNode,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#category : #'Toplo-Incubator'
}

{ #category : #initialization }
ToTabNode >> initialize [

	super initialize.
	self initializeForToplo.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #skin }
ToTabNode >> installRawStyle [

	| verticalPadding horizontalPadding |
	super installRawStyle.
	"self geometry: self tabGeometry."
	"self border: Color lightGray."
	self margin: (BlInsets horizontal: 3).
	verticalPadding := self valueOfTokenNamed: #'padding-content-V'.
	horizontalPadding := self valueOfTokenNamed: #'padding-content-H'.
	self padding:
		(BlInsets horizontal: horizontalPadding vertical: verticalPadding)
]

{ #category : #accessing }
ToTabNode >> tabGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 8;
			   topRight: 8;
			   bottomLeft: 0;
			   bottomRight: 0;
			   yourself)
]
