Class {
	#name : 'ToTheme',
	#superclass : 'Object',
	#classInstVars : [
		'current'
	],
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'cleanup' }
ToTheme class >> cleanUp [
	<script>

	current := nil
]

{ #category : 'cleanup' }
ToTheme class >> cleanUp: anObject [

	self cleanUp
]

{ #category : 'current' }
ToTheme class >> current [

	^ current ifNil: [ current := ToRawTheme new ]
]

{ #category : 'accessing' }
ToTheme >> name [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
ToTheme >> newSkinInstaller [

	^ self subclassResponsibility 
]

{ #category : 'printing' }
ToTheme >> printOn: aStream [

	aStream nextPutAll: '[Theme named: '; nextPutAll: self name; nextPutAll: ' ]'.
	super printOn: aStream
]

{ #category : 'accessing' }
ToTheme >> skinFor: anElement [

	^ self subclassResponsibility 
]

{ #category : 'styling' }
ToTheme >> styleSheet [

	^ nil
]
