"
https://ant.design/components/button

To trigger an operation.
When To Use

A button means an operation (or a series of operations). Clicking a button will trigger corresponding business logic.

In Ant Design we provide 5 types of button.

    Primary button: indicate the main action, one primary button at most in one section.
    Default button: indicate a series of actions without priority.
    Dashed button: used for adding action commonly.
    Text button: used for the most secondary action.
    Link button: used for external links.

And 4 other properties additionally.

    danger: used for actions of risk, like deletion or authorization.
    ghost: used in situations with complex background, home pages usually.
    disabled: when actions are not available.
    loading: add loading spinner in button, avoiding multiple submits too.
"
Class {
	#name : #ToAbstractButtonSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Skins'
}

{ #category : #testing }
ToAbstractButtonSkin class >> isAbstract [

	^ self = ToAbstractButtonSkin
]

{ #category : #accessing }
ToAbstractButtonSkin >> background [

	^ self tokens at: #background
]

{ #category : #accessing }
ToAbstractButtonSkin >> buildTokens [

	super buildTokens.
	
	self tokens at: #background put: self builtBackground.
]

{ #category : #accessing }
ToAbstractButtonSkin >> builtBackground [ 

	^ self subclassResponsibility 
]
