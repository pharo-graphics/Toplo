Class {
	#name : #ToSelectIconContainer,
	#superclass : #ToElement,
	#instVars : [
		'select',
		'icon'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectIconContainer >> icon [

	^ icon
]

{ #category : #accessing }
ToSelectIconContainer >> icon: anElement [

	anElement = icon ifTrue: [ ^ self ].
	icon ifNotNil: [ :s | icon removeFromParent ].
	anElement ifNil: [ ^ self ].
	anElement id: #icon.
	icon := anElement.
	self addChild: anElement
]

{ #category : #initialization }
ToSelectIconContainer >> initialize [

	super initialize.
	self
		fitContent;
		id: #iconContainer;
		layout: BlFrameLayout new;
		constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #skin }
ToSelectIconContainer >> newRawSkin [ 

	^ ToSelectIconContainerSkin new
]

{ #category : #'api - hooks' }
ToSelectIconContainer >> onInstalledIn: aSelect [

	select := aSelect.
	
]

{ #category : #'api - hooks' }
ToSelectIconContainer >> onUninstalledIn: aSelect [

	select := nil.
	icon := nil
]

{ #category : #accessing }
ToSelectIconContainer >> select [

	^ select
]
