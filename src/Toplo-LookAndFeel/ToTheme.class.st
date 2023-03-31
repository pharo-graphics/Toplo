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

{ #category : #border }
ToTheme >> borderRadius [
	"https://ant.design/components/button#design-token"
	
	^ 6
]

{ #category : #border }
ToTheme >> lineType [
	"https://ant.design/components/button#design-token"
	
	^ #solid
]

{ #category : #border }
ToTheme >> lineWidth [
	"https://ant.design/components/button#design-token"
	
	^ 1
]
