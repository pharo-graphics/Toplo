Class {
	#name : #ToSelectorPrinter,
	#superclass : #ToElementSelectorVisitor,
	#instVars : [
		'stream',
		'indentLevel'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #accessing }
ToSelectorPrinter >> contents [
	
	^ stream contents
]

{ #category : #'printing utility' }
ToSelectorPrinter >> indent [

	self indentLevel timesRepeat: [ self nextPut: '    ' ].
]

{ #category : #accessing }
ToSelectorPrinter >> indentLevel [

	^ indentLevel
]

{ #category : #accessing }
ToSelectorPrinter >> indentLevel: anObject [

	indentLevel := anObject
]

{ #category : #initialization }
ToSelectorPrinter >> initialize [ 

	super initialize.
	stream := String new writeStream.
	indentLevel := 0
]

{ #category : #private }
ToSelectorPrinter >> nextPut: aString [

	stream nextPutAll: aString
]

{ #category : #initialization }
ToSelectorPrinter >> reset [

	stream reset


]

{ #category : #accessing }
ToSelectorPrinter >> stream: aStream [

	stream := aStream
]

{ #category : #visiting }
ToSelectorPrinter >> visitActionSelector: aSelector [

	self nextPut: 'action:'.
	self nextPut: aSelector action printString
]

{ #category : #visiting }
ToSelectorPrinter >> visitAndSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' && '.
	aSelector right accept: self.
	self nextPut: ')'.
]

{ #category : #visiting }
ToSelectorPrinter >> visitChildSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' child:('.

	aSelector depth ifNil: [ aSelector right accept: self ] ifNotNil: [
		aSelector right accept: self.
		self nextPut: ' depth:'.
		self nextPut: aSelector depth printString ].
	self nextPut: ')'.
	self nextPut: ')'

]

{ #category : #visiting }
ToSelectorPrinter >> visitIdSelector: aSelector [

	self nextPut: 'id:'.
	self nextPut: aSelector id printString
]

{ #category : #visiting }
ToSelectorPrinter >> visitNotSelector: aSelector [

	self nextPut: 'not('.
	aSelector left accept: self.
	self nextPut: ')'.
]

{ #category : #visiting }
ToSelectorPrinter >> visitOrSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' || '.
	aSelector right accept: self.
	self nextPut: ')'.
]

{ #category : #visiting }
ToSelectorPrinter >> visitParentSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' parent:('.

	aSelector depth ifNil: [ aSelector right accept: self ] ifNotNil: [
		aSelector right accept: self.
		self nextPut: ' depth:'.
		self nextPut: aSelector depth printString ].
	self nextPut: ')'.
	self nextPut: ')'

]

{ #category : #visiting }
ToSelectorPrinter >> visitSiblingSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' sibling:('.
	aSelector right accept: self.
	self nextPut: ')'.
	self nextPut: ')'

]

{ #category : #visiting }
ToSelectorPrinter >> visitStyleStampSelector: aSelector [

	aSelector allStamps size = 1
		ifTrue: [
			self nextPut: 'stamp:'.
			self nextPut: aSelector allStamps anyOne printString ]
		ifFalse: [
			self nextPut: 'stamps:('.
			aSelector allStamps
				do: [ :stp | self nextPut: stp printString ]
				separatedBy: [ self nextPut: ', ' ].
			self nextPut: ')' ]
]

{ #category : #visiting }
ToSelectorPrinter >> visitTypeSelector: aSelector [

	self nextPut: 'type:'.
	self nextPut: aSelector type name
]

{ #category : #visiting }
ToSelectorPrinter >> visitUniversalSelector: aSelector [

	self nextPut: '*'
]
