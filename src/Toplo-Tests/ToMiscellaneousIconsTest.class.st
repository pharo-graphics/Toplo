"
I check that every icon `ToMiscellaneousIcons` defines in its accessing protocol is an SVG document that `ToMiscellaneousIcons class>>iconNamed:` turns into an SVG `ToImage`.
"
Class {
	#name : #ToMiscellaneousIconsTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #helpers }
ToMiscellaneousIconsTest >> iconNames [

	^ ToMiscellaneousIcons class selectorsInProtocol: #accessing
]

{ #category : #tests }
ToMiscellaneousIconsTest >> testIconNamedAnswersAnSvgImage [

	self iconNames do: [ :each |
		| image |
		image := ToMiscellaneousIcons iconNamed: each.
		self assert: (image isKindOf: ToImage).
		self assert: image innerSvgImage isNotNil ]
]

{ #category : #tests }
ToMiscellaneousIconsTest >> testIconsAreSvgDocuments [

	self denyEmpty: self iconNames.
	self iconNames do: [ :each | self assert: ((ToMiscellaneousIcons innerImageNamed: each) includesSubstring: '<svg') ]
]
