
'use strict';

var ReactNative = require('react-native');
var React = require('react');
var PropTypes = require('prop-types');
var {
    requireNativeComponent,
    View,
    UIManager,
    DeviceEventEmitter
} = ReactNative;

class SignatureCapture extends React.Component {

    constructor() {
        super();
        this.onChange = this.onChange.bind(this);
        this.onStartDrag = this.onStartDrag.bind(this);
        this.onSave = this.onSave.bind(this);
        this.subscriptions = [];
    }

    onChange(event) {

        if (event.nativeEvent.pathName) {

            if (!this.props.onSaveEvent) {
                return;
            }
            this.props.onSaveEvent({
                pathName: event.nativeEvent.pathName,
                encoded: event.nativeEvent.encoded,
            });
        }

        if (event.nativeEvent.dragged) {
            if (!this.props.onDragEvent) {
                return;
            }
            this.props.onDragEvent({
                dragged: event.nativeEvent.dragged
            });
        }
    }

    componentDidMount() {
        if (this.props.onSaveEvent) {
            let sub = DeviceEventEmitter.addListener(
                'onSaveEvent',
                this.props.onSaveEvent
            );
            this.subscriptions.push(sub);
        }

        if (this.props.onDragEvent) {
            let sub = DeviceEventEmitter.addListener(
                'onDragEvent',
                this.props.onDragEvent
            );
            this.subscriptions.push(sub);
        }
    }

    componentWillUnmount() {
        this.subscriptions.forEach(sub => sub.remove());
        this.subscriptions = [];
    }

    onStartDrag(event) {
        this.props.onDragEvent(event)
    }

    onSave(event) {
        this.props.onSaveEvent(event.nativeEvent)
    }

    render() {
        return (
            <RSSignatureView {...this.props} onChange={this.onChange} onStartDrag={this.onStartDrag} onSave={this.onSave} />
        );
    }

    saveImage() {
        UIManager.dispatchViewManagerCommand(
            ReactNative.findNodeHandle(this),
            UIManager.RSSignatureView.Commands.saveImage,
            [],
        );
    }

    resetImage() {
        UIManager.dispatchViewManagerCommand(
            ReactNative.findNodeHandle(this),
            UIManager.RSSignatureView.Commands.resetImage,
            [],
        );
    }
}

SignatureCapture.propTypes = {
    ...View.propTypes,
    rotateClockwise: PropTypes.bool,
    square: PropTypes.bool,
    saveImageFileInExtStorage: PropTypes.bool,
    viewMode: PropTypes.string,
    showBorder: PropTypes.bool,
    showNativeButtons: PropTypes.bool,
    showTitleLabel: PropTypes.bool,
    maxSize: PropTypes.number,
    minStrokeWidth: PropTypes.number,
    maxStrokeWidth: PropTypes.number,
    strokeColor: PropTypes.string,
    backgroundColor: PropTypes.string,
    onStartDrag: PropTypes.func,
    onSave: PropTypes.func,

};

var RSSignatureView = requireNativeComponent('RSSignatureView', SignatureCapture, {
    nativeOnly: { onChange: true }
});

module.exports = SignatureCapture;
