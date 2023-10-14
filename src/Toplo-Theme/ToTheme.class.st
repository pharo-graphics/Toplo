Class {
	#name : 'ToTheme',
	#superclass : 'Object',
	#classInstVars : [
		'current'
	],
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
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
ToTheme >> skinBuilder [

	^ self subclassResponsibility 
]

{ #category : 'styling' }
ToTheme >> styleSheet [

	^ nil
]
