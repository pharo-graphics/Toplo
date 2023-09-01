"
I am a STON reader specialised on reading an ToStyle.

Contrary to my parent, I accept .class [ ... ] constructions.
"
Class {
	#name : #ToStyleSTONReader,
	#superclass : #STONReader,
	#instVars : [
		'currentStyle'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #'instance creation' }
ToStyleSTONReader class >> fromStream: readStream [

	^ (self on: readStream) next
]

{ #category : #'instance creation' }
ToStyleSTONReader class >> fromString: aString [

	^ self fromStream: aString readStream
]

{ #category : #testing }
ToStyleSTONReader >> isClassChar: char [
	
	^ (super isClassChar: char) or: [ char = $: ]
]

{ #category : #private }
ToStyleSTONReader >> isStyleClassChar: char [ 

	^ char = $.
]

{ #category : #private }
ToStyleSTONReader >> lookupClass: name [

	"The ToStyleSTONReader only looks for ston names in the hierarchy of ToStyle"
	
	^ classes 
		at: name 
		ifAbsentPut: [ 
			self styleClasses 
				detect: [ :class | class isMeta not and: [ class stonName = name ]  ]
				ifNone: [ NotFound signalFor: name ] ]
]

{ #category : #parsing }
ToStyleSTONReader >> parseSimpleValue [
	| char |

	readStream atEnd ifFalse: [ 
		char := readStream peek.
		(self isStyleClassChar: char) ifTrue: [ 
			^ self parseStyleClass ] ].

	^ super parseSimpleValue
]

{ #category : #parsing }
ToStyleSTONReader >> parseStyleClass [
	| name reference style |

	[
		reference := self newReference.
		name := self parseStyleName.
		style := self styleClass new
			name: name;
			parent: currentStyle;
			yourself.
		self 
			pushStyle: style 
			during: [ style fromSton: self ]. 
		self setReference: reference to: style ]
	on: NotFound 
	do: [ :notFound |
		acceptUnknownClasses 
			ifTrue: [ 
				style := STON mapClass new.
				self storeReference: style.
				self parseMapDo: [ :key :value |
					style at: key put: value ].
				style at: STON classNameKey put: notFound object ]
			ifFalse: [ self error: 'Cannot resolve class named ', notFound object printString ] ].
	
	^ style
]

{ #category : #'private parsing' }
ToStyleSTONReader >> parseStyleName [
	| styleName |

	readStream next. "ignore dot"
	styleName := self stringStreamContents: [ :stream |
		[ readStream atEnd not and: [ self isClassChar: readStream peek ] ] whileTrue: [ 
			stream nextPut: readStream next ] ].
	self consumeWhitespace.
	^ styleName asString
]

{ #category : #accessing }
ToStyleSTONReader >> pushStyle: aStyle during: aBlock [
	| oldStyle |
	
	oldStyle := currentStyle.
	currentStyle := aStyle.
	aBlock ensure: [ 
		currentStyle := oldStyle ]
]

{ #category : #private }
ToStyleSTONReader >> styleClass [

	^ ToClassStyle
]

{ #category : #private }
ToStyleSTONReader >> styleClasses [

	^ ToStyle allSubclasses, Color withAllSubclasses
]
