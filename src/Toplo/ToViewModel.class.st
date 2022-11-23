Class {
	#name : #ToViewModel,
	#superclass : #ToCompanion,
	#instVars : [
		'#enabled => ObservableSlot',
		'#help => ObservableSlot',
		'#helpEventHandler'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - install/uninstall  hook' }
ToViewModel >> afterInstallationIn: anElement [

	self runPostponedActions
]

{ #category : #'api - install/uninstall  hook' }
ToViewModel >> beforeInstallationIn: anElement [

	super beforeInstallationIn: anElement.
	self stopPostponedActionsStorageFor: anElement
]

{ #category : #'api - enablement' }
ToViewModel >> disable [
	"Disable the view"
	
	self enabled: false
]

{ #category : #'api - enablement' }
ToViewModel >> enable [
	"Enable the view"
	
	self enabled: true
]

{ #category : #'api - enablement' }
ToViewModel >> enabled: aBooleanOrValuable [
	"Set if the widget is enabled (clickable or focusable).
	This can either be a boolean or a block returning a boolean."

	enabled := aBooleanOrValuable.
	self widgetDo: [ :widget | widget enablementChangedWith: enabled ]
	
]

{ #category : #'api - help' }
ToViewModel >> help [
	"Return the help string to display as help (tooltip) to the user."

	^ help
]

{ #category : #'api - help' }
ToViewModel >> help: aText [
	"Set a help text to display to the user if he let the mouse over the widget (a tooltip)."

	help := aText
]

{ #category : #'api - help' }
ToViewModel >> helpString: aString [
	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self help: aString asRopedText
]

{ #category : #initialization }
ToViewModel >> initialize [ 

	super initialize.
	self startPostponedActionsStorage
]

{ #category : #'change reporting' }
ToViewModel >> invalidate [

	" invalidate was sent to the widget. Subclasses may have action to run model side before invalidation"
]

{ #category : #'api - install/uninstall  hook' }
ToViewModel >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	helpEventHandler := ToWidgetHelpEventHandler new.
	anElement addEventHandler: helpEventHandler
]

{ #category : #'api - install/uninstall  hook' }
ToViewModel >> onUninstalledIn: anElement [

	"Is sent when I am removed from an element "

	super onUninstalledIn: anElement.
	self unsubscribe: anElement.
	helpEventHandler ifNotNil: [ 
		anElement removeEventHandler: helpEventHandler.
		helpEventHandler := nil ]

]

{ #category : #'accessing - widget' }
ToViewModel >> onWidget [

	^ self privateNewWidget
]

{ #category : #'private-postponed actions' }
ToViewModel >> postponedActions [

	^ self userData at: #postponedActions ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #'private - accessing - widget' }
ToViewModel >> privateNewWidget [

	^ self privateWidgetClass new
		  viewModel: self;
		  yourself
]

{ #category : #'private - accessing - widget' }
ToViewModel >> privateWidgetClass [

	^ self subclassResponsibility 
]

{ #category : #'private-postponed actions' }
ToViewModel >> removePostponedActions [

	self userData removeKey: #postponedActions ifAbsent: [  ]
]

{ #category : #'private-postponed actions' }
ToViewModel >> runPostponedActions [

	self postponedActions do: [ :announcement | self announce: announcement ].
	self removePostponedActions
]

{ #category : #'private-postponed actions' }
ToViewModel >> startPostponedActionsStorage [

	self whenAnnouncement: ToActionRequiredInWidget send: #whenActionRequiredInWidget: to: self
]

{ #category : #'private-postponed actions' }
ToViewModel >> stopPostponedActionsStorageFor: anElement [

	self unsubscribe: self.
	self whenAnnouncement: ToActionRequiredInWidget send: #whenActionRequired: to: anElement

]

{ #category : #'private - accessing - widget' }
ToViewModel >> whenActionRequiredInWidget: anActionRequired [

	self postponedActions add: anActionRequired.
]

{ #category : #'api - properties change hook' }
ToViewModel >> whenEnabledChangedDo: aBlock [
	"Inform when enabled status has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #enabled whenChangedDo: aBlock
]

{ #category : #'api - properties change hook' }
ToViewModel >> whenHelpChangedDo: aBlock [
	"Inform when help property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #help whenChangedDo: aBlock
]

{ #category : #'accessing - widget' }
ToViewModel >> widgetDo: aBlock [

	self widgetPerformOrDefer: aBlock
]

{ #category : #'accessing - widget' }
ToViewModel >> widgetPerformOrDefer: aBlock [

	self announce: (ToActionRequiredInWidget new
			 valuable: aBlock;
			 yourself)
]
