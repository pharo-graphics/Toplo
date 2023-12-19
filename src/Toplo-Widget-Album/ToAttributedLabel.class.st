Class {
	#name : 'ToAttributedLabel',
	#superclass : 'ToLabel',
	#category : 'Toplo-Widget-Album-Label',
	#package : 'Toplo-Widget-Album',
	#tag : 'Label'
}

{ #category : 'initialization' }
ToAttributedLabel >> initialize [

	super initialize.
	self attributesBuilder attributesTarget: self text.
	self attributesBuilder whenAdded: [ self applyAttributesBuilder ].
	self withoutSkin
]

{ #category : 'private-change' }
ToAttributedLabel >> privateText: aText [

	super privateText: aText.
	self attributesBuilder attributesTarget: self text.
	self applyAttributesBuilder
]

{ #category : 'event handling' }
ToAttributedLabel >> textChanged [

	self applyAttributesBuilder.
	"super textChanged"
]
