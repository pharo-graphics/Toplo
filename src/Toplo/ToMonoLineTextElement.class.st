Class {
	#name : #ToMonoLineTextElement,
	#superclass : #BlAttributedTextElement,
	#traits : 'TOBlLayoutResizable',
	#classTraits : 'TOBlLayoutResizable classTrait',
	#category : #'Toplo-Widget-Label'
}

{ #category : #'event handling' }
ToMonoLineTextElement >> textChanged [

	super textChanged.
	self dispatchEvent: (ToTextReplacedEvent new text: self text)
	
]
