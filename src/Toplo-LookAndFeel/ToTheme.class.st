Class {
	#name : #ToTheme,
	#superclass : #ToAbstractTheme,
	#category : #'Toplo-LookAndFeel-Theme'
}

{ #category : #testing }
ToTheme class >> default [

	^ ToClearTheme new
]

{ #category : #testing }
ToTheme class >> isAbstract [

	^ self = ToTheme
]
