"
I'm a composite icon provider.
Users can compose (using `,` message) icon providers to define different ways to find icons.
A typical usage is: 

```
(ToLocationIconProvider newLocation: './icons' asFileReference), ToPharoThemeIconProvider new
```
"
Class {
	#name : #ToCompositeIconProvider,
	#superclass : #ToIconProvider,
	#instVars : [
		'providers'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #copying }
ToCompositeIconProvider >> , aProvider [

	self addProvider: aProvider.
	^ self
]

{ #category : #accessing }
ToCompositeIconProvider >> addProvider: anIconProvider [

	providers := providers copyWith: anIconProvider
]

{ #category : #accessing }
ToCompositeIconProvider >> iconNamed: aName ifAbsent: aBlock [

	self providers do: [ :each |
		(each iconNamed: aName ifAbsent: [ nil ]) 
			ifNotNil: [ :icon | ^ icon ] ].
	
	^ aBlock value
]

{ #category : #initialization }
ToCompositeIconProvider >> initialize [

	super initialize.
	providers := #()
]

{ #category : #accessing }
ToCompositeIconProvider >> providers [
	
	^ providers
]
