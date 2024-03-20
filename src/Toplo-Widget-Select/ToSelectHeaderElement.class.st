Class {
	#name : #ToSelectHeaderElement,
	#superclass : #ToElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'select',
		'headerNodeContainer'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectHeaderElement >> headerNodeContainer [

	^ headerNodeContainer 
]

{ #category : #initialization }
ToSelectHeaderElement >> initialize [

	super initialize.
	self
		vFitContent;
		hMatchParent;
		id: #headerElement;
		constraintsDo: [ :c | c linear vertical alignCenter ].
		
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		event placeholder padding: (BlInsets left: 5).
		event placeholder layout alignCenterLeft ]
]

{ #category : #'instance creation' }
ToSelectHeaderElement >> newHeaderNodeContainer [

	^ select strategy headerNodeContainerClass new
		  id: #headerNodeContainer;
		  yourself
]

{ #category : #'api - hooks' }
ToSelectHeaderElement >> onInstalledIn: aSelect [

	select := aSelect.
	" the element that contains nodes + the text field "
	headerNodeContainer := self newHeaderNodeContainer.
	headerNodeContainer onInstalledIn: select.
	self addChild: headerNodeContainer.


]

{ #category : #'api - hooks' }
ToSelectHeaderElement >> onUninstalledIn: aSelect [

	headerNodeContainer onUninstalledIn: aSelect.
	headerNodeContainer removeFromParent.
	headerNodeContainer := nil.
	select := nil
]

{ #category : #window }
ToSelectHeaderElement >> onWindowClosed [

	self headerNodeContainer onWindowClosed
]

{ #category : #window }
ToSelectHeaderElement >> onWindowOpened [

	self headerNodeContainer onWindowOpened
]
